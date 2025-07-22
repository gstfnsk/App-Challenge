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

    var localizedDescription: String? {
        switch self {
        case .unknown:
            return "Ocorreu um erro desconhecido."
        case .notImplemented:
            return "Este recurso ainda não foi implementado."
        case .accountRestricted:
            return "Sua conta do iCloud está restrita."
        case .accountUnavailable:
            return
                "Sua conta do iCloud está indisponível no momento. Por favor, faça login no iCloud e tente novamente mais tarde."
        case .noAccount:
            return
                "Nenhuma conta do iCloud está configurada neste dispositivo. Por favor, faça login no iCloud e tente novamente mais tarde."
        }
    }
}

class CloudKitManager: FreelaOnTapPersistence {
    // Shared singleton instance
    static let shared = CloudKitManager()
    static let allWithIdPredicate = NSPredicate(format: "id != %@", "")

    // Prevent external instantiation
    private init() {
        containerIdentifier = "iCloud.br.poa.academy.freelaOnTap"
        container = CKContainer(identifier: containerIdentifier)
        publicDatabase = container.publicCloudDatabase
        userPrivateDatabase = container.privateCloudDatabase
    }

    let containerIdentifier: String
    let container: CKContainer
    let publicDatabase: CKDatabase
    let userPrivateDatabase: CKDatabase

    // Record Type Identifiers
    let jobOfferRecordType = "JobOffer"
    let companyProfileRecordType = "CompanyProfile"

    // Cache
    var cache: (jobOffers: [UUID: JobOffer], companyProfiles: [UUID: CompanyProfile]) =
        (jobOffers: [:], companyProfiles: [:])

    // MARK: - Check iCloud Availability
    // Throws if iCloud is not available or user is not logged in
    func throwIfICloudNotAvailable() async throws {
        let status = await getStatus()

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

    func getStatus() async -> CKAccountStatus {
        return try! await self.container.accountStatus()
    }

    func fetchRecords<T>(
        ofType recordType: String,
        database: CKDatabase = CloudKitManager.shared.publicDatabase,
        matching predicate: NSPredicate = NSPredicate(value: true),
        decode: (CKRecord) -> T?
    ) async throws -> [T] {
        try await throwIfICloudNotAvailable()

        let query = CKQuery(recordType: recordType, predicate: predicate)
        let (matchResults, _) = try await database.records(matching: query)

        var results: [T] = []

        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                guard let item = decode(record) else {
                    print("Warning: Could not decode record \(record.recordID)")
                    continue
                }
                results.append(item)
            case .failure(let error):
                throw error
            }
        }

        return results
    }

    func deleteRecord(with uuid: UUID, database: CKDatabase = CloudKitManager.shared.publicDatabase) async throws {
        let recordID = CKRecord.ID(recordName: uuid.uuidString)
        try await deleteRecord(with: recordID, database: database)
    }

    func deleteRecord(with recordID: CKRecord.ID, database: CKDatabase = CloudKitManager.shared.publicDatabase) async throws {
        try await throwIfICloudNotAvailable()
        try await database.deleteRecord(withID: recordID)
    }
}
