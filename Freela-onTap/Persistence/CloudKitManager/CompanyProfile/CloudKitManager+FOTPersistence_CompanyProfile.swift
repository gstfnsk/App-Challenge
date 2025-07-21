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
        return try await fetchAllCompanies(forceUpdate: false)
    }

    func fetchAllCompanies(forceUpdate: Bool = false) async throws -> [CompanyProfile] {
        try await throwIfICloudNotAvailable()

        if self.cache.companyProfiles.isEmpty || forceUpdate {
            let companies: [CompanyProfile] = try await fetchRecords(
                ofType: companyProfileRecordType,
                matching: Self.allWithIdPredicate,
                decode: CompanyProfile.init(record:)
            )

            var companyMap: [UUID: CompanyProfile] = [:]

            for company in companies {
                companyMap.updateValue(company, forKey: company.id)
            }

            self.cache.companyProfiles = companyMap
        }

        return Array(self.cache.companyProfiles.values)
    }

    func fetchCompany(id: UUID) async throws -> CompanyProfile? {
        try await throwIfICloudNotAvailable()
        
        if let cached = self.cache.companyProfiles[id] {
            return cached
        }

        _ = try? await fetchAllCompanies(forceUpdate: true)
        return self.cache.companyProfiles[id]
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

        try await publicDatabase.save(record)
    }

    // MARK: - Delete Company
    func deleteCompany(_ company: CompanyProfile) async throws {
        try await throwIfICloudNotAvailable()

        try await deleteCompany(companyUUID: company.id)
    }

    func deleteCompany(companyUUID id: UUID) async throws {
        try await throwIfICloudNotAvailable()

        let recordID = CKRecord.ID(recordName: id.uuidString)
        try await publicDatabase.deleteRecord(withID: recordID)
    }
}
