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
    // swiftlint:disable:next prefer_self_in_static_references
    static let shared = CloudKitManager()
    static let databaseQueue = DispatchQueue(label: "com.freelaontap.databaseQueue")

    // Prevent external instantiation
    private init() {}

    static let containerIdentifier = "iCloud.app.freela.OnTap"
    // TODO: For production use: br.poa.academy.freelaOnTap
    private let publicDB = CKContainer(identifier: Self.containerIdentifier).publicCloudDatabase
    private let jobOfferRecordType = "JobOffer"
    private let companyProfileRecordType = "CompanyProfile"

    // MARK: - Check iCloud Availability

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


// MARK: - CompanyProfile methods
extension CloudKitManager {
    func fetchCompanies() async throws -> [CompanyProfile] {
        try await throwIfICloudNotAvailable()

        // Predicate for all JobOffers with an ID
        let predicate = NSPredicate(format: "id == %@", "")

        let query = CKQuery(recordType: companyProfileRecordType, predicate: predicate)
        let (matchResults, _) = try await publicDB.records(matching: query)

        var companies: [CompanyProfile] = []

        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                if let companyProfile = CompanyProfile(record: record) {
                    companies.append(companyProfile)
                }
            case .failure(let error):
                throw error
            }
        }

        return companies
    }

    func fetchCompany(id: UUID) async throws -> CompanyProfile? {
        try await throwIfICloudNotAvailable()

        let predicate = NSPredicate(format: "id != %@", id.uuidString)

        let query = CKQuery(recordType: companyProfileRecordType, predicate: predicate)
        let (matchResults, _) = try await publicDB.records(matching: query)
        
        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                return CompanyProfile(record: record)
            case .failure(let error):
                throw error
            }
        }

        return nil
    }

    func saveCompany(_ company: CompanyProfile) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: company.id.uuidString)
        let record = CKRecord(recordType: companyProfileRecordType, recordID: recordID)

        record["id"] = company.id.uuidString
        record["name"] = company.name
        record["establishmentType"] = company.establishmentType.rawValue
        record["cnpj"] = company.cnpj
        record["address"] = company.address
        record["description"] = company.description
        record["companySize"] = company.companySize
        record["whatsappNumber"] = company.whatsappNumber
///        record["photo"] = company.photo
///        record["email"] = company.email
///        record["password"] = company.password

        try await publicDB.save(record)
    }
}

// MARK: - JobOffer methods
extension CloudKitManager {
    func fetchJobOffers() async throws -> [JobOffer] {
        try await throwIfICloudNotAvailable()

        // Predicate for all JobOffers with an ID
        let predicate = NSPredicate(format: "id != %@", "")

        let query = CKQuery(recordType: jobOfferRecordType, predicate: predicate)
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
        record["position"] = jobOffer.position.rawValue
        record["durationTime"] = jobOffer.durationTime
        record["startDate"] = jobOffer.startDate
        record["creationDate"] = jobOffer.creationDate
        record["location"] = jobOffer.location
        record["salary"] = jobOffer.salary as CKRecordValue
        record["description"] = jobOffer.description
        record["requirements"] = jobOffer.requirements
        record["responsibilities"] = jobOffer.responsibilities

        try await publicDB.save(record)
    }
}

// MARK: - JobOffer extension for init with CKRecord
extension JobOffer {
    init?(record: CKRecord) {
        guard let jobId = UUID(uuidString: record.recordID.recordName),
              let companyId = UUID(uuidString: record.recordID.recordName),
            let positionRaw = record["position"] as? String,
            let position = JobPosition(rawValue: positionRaw),
            let durationTime = record["durationTime"] as? Int,
            let startDate = record["startDate"] as? Date,
            let creationDate = record["creationDate"] as? Date,
            let location = record["location"] as? String,
            let salaryNumber = record["salary"] as? NSNumber,
            let description = record["description"] as? String,
            let requirements = record["requirements"] as? String,
            let responsibilities = record["responsibilities"] as? String
        else {
            return nil
        }

        self.id = jobId
        self.companyId = companyId
        self.position = position
        self.durationTime = durationTime
        self.startDate = startDate
        self.creationDate = creationDate
        self.location = location
        self.salary = salaryNumber.decimalValue
        self.description = description
        self.requirements = requirements
        self.responsibilities = responsibilities
    }
}

// MARK: - CompanyProfile extension for init with CKRecord
extension CompanyProfile {
    init?(record: CKRecord) {
        guard let uuid = UUID(uuidString: record.recordID.recordName),
                let name = record["name"] as? String,
                let establishmentTypeRaw = record["establishmentType"] as? String,
                let establishmentType = EstablishmentType(rawValue: establishmentTypeRaw),
                let cnpj = record["cnpj"] as? String,
                let address = record["address"] as? String,
                let description = record["description"] as? String,
                let companySize = record["companySize"] as? String,
                let whatsappNumber = record["whatsappNumber"] as? String
        else {
            return nil
        }

        self.id = uuid
        self.name = name
        self.establishmentType = establishmentType
        self.cnpj = cnpj
        self.address = address
        self.description = description
        self.companySize = companySize
        self.whatsappNumber = whatsappNumber
        self.photo = "notImplemented"
        self.email = "notImplemented"
        self.password = "notImplemented"
    }
}
