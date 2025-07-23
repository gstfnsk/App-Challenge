//
//  CloudKitManager+FOTPersistence_CompanyProfile.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 19/06/25.
//

import CloudKit

// MARK: - CompanyProfile methods
extension CloudKitManager: FreelaOnTapPersistence_CompanyProfile {
    func fetchAllCompanies() async throws -> [CompanyProfile] {
        try await throwIfICloudNotAvailable()

        // Predicate for all JobOffers with an ID
        let predicate = CloudKitManager.allWithIdPredicate

        let query = CKQuery(recordType: companyProfileRecordType, predicate: predicate)
        let (matchResults, _) = try await publicDB.records(matching: query)

        var companies: [CompanyProfile] = []
        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                if let companyProfile = CompanyProfile(record: record) {
                    companies.append(companyProfile)
                } else {
                    print("Could not initialize CompanyProfile from record.")
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

    // MARK: - Save CompanyProfile to CloudKit

    func saveCompany(_ company: CompanyProfile) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: company.id.uuidString)
        let record = CKRecord(recordType: companyProfileRecordType, recordID: recordID)

        record["id"] = company.id.uuidString
        record["name"] = company.name
        record["establishmentType"] = company.establishmentType.caseName
        record["cnpj"] = company.cnpj
        record["whatsappNumber"] = company.whatsappNumber
        record["description"] = company.description
        record["companySize"] = company.companySize.rawValue

        // Save address parts separately
        record["address_streetAndNumber"] = company.address.streetAndNumber
        record["address_neighborhood"] = company.address.neighborhood
        record["address_cityAndState"] = company.address.cityAndState

        try await publicDB.save(record)
    }

    // MARK: - Delete Company
    func deleteCompany(_ company: CompanyProfile) async throws {
        try await throwIfICloudNotAvailable()

        try await deleteCompany(companyUUID: company.id)
    }

    func deleteCompany(companyUUID id: UUID) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: id.uuidString)
        try await publicDB.deleteRecord(withID: recordID)
    }
}
