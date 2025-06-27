//
//  CloudKitManager+FOTPersistence_JobOffer.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 19/06/25.
//

import CloudKit



// MARK: - JobOffer methods
extension CloudKitManager: FreelaOnTapPersistence_JobOffer {
    func fetchAllJobOffers(forceUpdate: Bool = false) async throws -> [JobOffer] {
        
        if(CloudKitManager.jobOfferCache.isEmpty || forceUpdate){
            try await throwIfICloudNotAvailable()
            
            // Predicate for all JobOffers with an ID
            let predicate = CloudKitManager.allWithIdPredicate

            let query = CKQuery(recordType: jobOfferRecordType, predicate: predicate)
            let (matchResults, _) = try await publicDB.records(matching: query)

            CloudKitManager.companyProfileCache = (try? await CloudKitManager.shared.fetchAllCompanies()) ?? []
            var companyProfileCache: [UUID: CompanyProfile] = [:]
            for company in CloudKitManager.companyProfileCache {
                companyProfileCache[company.id] = company
            }
            
            var jobOfferList: [JobOffer] = []
            
            for (_, result) in matchResults {
                switch result {
                case .success(let record):
                    if var jobOffer = JobOffer(record: record) {
                        
                        jobOffer.company = companyProfileCache[jobOffer.companyId]
                        jobOfferList.append(jobOffer)
                    }
                case .failure(let error):
                    throw error
                }
            }
            
            CloudKitManager.jobOfferCache = jobOfferList
        }
        
        return CloudKitManager.jobOfferCache
    }
    
    func fetchAllJobOffers() async throws -> [JobOffer] {
        try await fetchAllJobOffers(forceUpdate: false)
    }
        

    func fetchJobOffer(id: UUID) async throws -> JobOffer? {
        try await throwIfICloudNotAvailable()

        let predicate = NSPredicate(format: "id == %@", id.uuidString)

        let query = CKQuery(recordType: jobOfferRecordType, predicate: predicate)
        let (matchResults, _) = try await publicDB.records(matching: query)
        
        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                return JobOffer(record: record)
            case .failure(let error):
                throw error
            }
        }

        return nil
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
        
        try await publicDB.save(record)
    }
    
    // MARK: - Delete JobOffer
    
    func deleteJobOffer(jobOfferUUID id: UUID) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: id.uuidString)
        try await publicDB.deleteRecord(withID: recordID)
    }
    
    func deleteJobOffer(_ jobOffer: JobOffer) async throws {
        try await throwIfICloudNotAvailable()
        
        try await deleteJobOffer(jobOfferUUID: jobOffer.id)
    }
}
