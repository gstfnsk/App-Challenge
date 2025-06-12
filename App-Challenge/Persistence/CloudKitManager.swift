//
//  CloudKitManager.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 11/06/25.
//

import CloudKit

enum CloudKitError: Error {
    case unknown
    case notImplemented

    // iCloud account errors
    case accountRestricted
    case accountUnavailable
    case noAccount
}

struct CloudKitManager: FreelaOnTapPersistence {
    // Shared singleton instance
    static let shared = CloudKitManager()
    static let databaseQueue = DispatchQueue(label: "com.freelaontap.databaseQueue")

    // Prevent external instantiation
    private init() {}

    static let containerIdentifier = "iCloud.app.freela.OnTap"
    // TODO: For production use: br.poa.academy.freelaOnTap
    private let publicDB = CKContainer(identifier: Self.containerIdentifier).publicCloudDatabase

    // MARK: - Check iCloud Avaliability

    // Throws if iCloud is not available or user is not logged in
    func throwIfICloudNotAvailable() async throws {
        let status = try await CKContainer.default().accountStatus()

        switch status {
        case .available:
            return  // All good, proceed
        case .noAccount:
            throw CloudKitError.noAccount
        case .restricted:
            throw CloudKitError.accountRestricted
        case .couldNotDetermine:
            throw CloudKitError.accountUnavailable
        default:
            throw CloudKitError.accountUnavailable
        }
    }
}

extension CloudKitManager {
    func fetchCompanies() async throws -> [CompanyProfile] {
        try await throwIfICloudNotAvailable()

        throw CloudKitError.notImplemented
    }

    func fetchCompany(id: UUID) async throws -> CompanyProfile? {
        try await throwIfICloudNotAvailable()

        throw CloudKitError.notImplemented
    }

    func saveCompany(_ company: CompanyProfile) async throws {
        try await throwIfICloudNotAvailable()

        throw CloudKitError.notImplemented
    }
}

extension CloudKitManager {
    func fetchJobOffers() async throws -> [JobOffer] {
        try await throwIfICloudNotAvailable()

        // Predicate for all JobOffers with an ID
        let predicate = NSPredicate(format: "jobOfferId == %@", "")

        let query = CKQuery(recordType: "JobOffer", predicate: predicate)
        let (matchResults, _) = try await publicDB.records(matching: query)

        var offers: [JobOffer] = []

        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                if let jobOffer = JobOffer(record: record) {
                    offers.append(jobOffer)
                }
            case .failure(let error):
                throw error
            }
        }

        return offers
    }

    func fetchJobOffer(id: UUID, includeCompany: Bool) async throws -> JobOffer? {
        try await throwIfICloudNotAvailable()

        // Predicate for all JobOffers with an ID
        let predicate = NSPredicate(format: "jobOfferId != %@", id.uuidString)

        let query = CKQuery(recordType: "JobOffer", predicate: predicate)
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
        let record = CKRecord(recordType: "JobOffer", recordID: recordID)

        record["jobOfferId"] = jobOffer.id.uuidString
        record["companyId"] = jobOffer.companyId?.uuidString
        record["position"] = jobOffer.position.rawValue
        record["durationTime"] = jobOffer.durationTime
        record["startDate"] = jobOffer.startDate
        record["location"] = jobOffer.location
        record["salary"] = jobOffer.salary as CKRecordValue
        record["description"] = jobOffer.description
        record["requirements"] = jobOffer.requirements
        record["responsibilities"] = jobOffer.responsibilities

        try await publicDB.save(record)
    }
}

extension JobOffer {
    init?(record: CKRecord) {
        guard let uuid = UUID(uuidString: record.recordID.recordName),
            let positionRaw = record["position"] as? String,
            let position = JobPosition(rawValue: positionRaw),
            let durationTime = record["durationTime"] as? Int,
            let startDate = record["startDate"] as? Date,
            let location = record["location"] as? String,
            let salaryNumber = record["salary"] as? NSNumber,
            let description = record["description"] as? String,
            let requirements = record["requirements"] as? String,
            let responsibilities = record["responsibilities"] as? String
        else {
            return nil
        }

        self.id = uuid
        self.position = position
        self.durationTime = durationTime
        self.startDate = startDate
        self.location = location
        self.salary = salaryNumber.decimalValue
        self.description = description
        self.requirements = requirements
        self.responsibilities = responsibilities
    }
}
