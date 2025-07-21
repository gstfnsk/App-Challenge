//
//  CloudKitManager+FOTPersistence_JobOffer.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 19/06/25.
//

import CloudKit



// MARK: - JobOffer methods
extension CloudKitManager: FreelaOnTapPersistence_JobOffer {
    func fetchAllJobOffers() async throws -> [JobOffer] {
        return try await fetchAllJobOffers(forceUpdate: false)
    }
    
    func fetchAllJobOffers(forceUpdate: Bool = false) async throws -> [JobOffer] {
        try await throwIfICloudNotAvailable()

        if self.cache.jobOffers.isEmpty || forceUpdate {
            let jobOffers: [JobOffer] = try await fetchRecords(
                ofType: jobOfferRecordType,
                matching: Self.allWithIdPredicate,
                decode: JobOffer.init(record:)
            )

            var jobOfferMap: [UUID: JobOffer] = [:]

            for var offer in jobOffers {
                offer.company = try? await fetchCompany(id: offer.companyId)
                jobOfferMap.updateValue(offer, forKey: offer.id)
            }

            self.cache.jobOffers = jobOfferMap
        }

        return Array(self.cache.jobOffers.values)
    }
        

    func fetchJobOffer(id: UUID) async throws -> JobOffer? {
        try await throwIfICloudNotAvailable()
        
        if let cached = self.cache.jobOffers[id] {
            return cached
        }

        _ = try? await fetchAllJobOffers(forceUpdate: true)
        return self.cache.jobOffers[id]
    }

    func saveJobOffer(_ jobOffer: JobOffer) async throws {
        try await throwIfICloudNotAvailable()
        
        let recordID = CKRecord.ID(recordName: jobOffer.id.uuidString)
        let record = CKRecord(recordType: jobOfferRecordType, recordID: recordID)
        
        record["id"] = jobOffer.id.uuidString
        record["companyId"] = jobOffer.companyId.uuidString
        record["postedAt"] = jobOffer.postedAt
        record["title"] = jobOffer.title.caseName
        record["titleOther"] = jobOffer.titleOther as CKRecordValue?
        record["durationInHours"] = jobOffer.durationInHours
        record["startDate"] = jobOffer.startDate
        record["salaryBRL"] = jobOffer.salaryBRL as CKRecordValue
        record["description"] = jobOffer.description
        record["qualifications"] = jobOffer.qualifications
        record["duties"] = jobOffer.duties
        
        try await publicDatabase.save(record)
    }
    
    // MARK: - Delete JobOffer
    
    func deleteJobOffer(jobOfferUUID id: UUID) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: id.uuidString)
        try await publicDatabase.deleteRecord(withID: recordID)
    }
    
    func deleteJobOffer(_ jobOffer: JobOffer) async throws {
        try await throwIfICloudNotAvailable()
        
        try await deleteJobOffer(jobOfferUUID: jobOffer.id)
    }
}
