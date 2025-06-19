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
    // Prevent external instantiation
    private init() {}
    
    
    static let containerIdentifier = "iCloud.br.poa.academy.freelaOnTap"
    internal let publicDB = CKContainer(identifier: Self.containerIdentifier).publicCloudDatabase
    internal let jobOfferRecordType = "JobOffer"
    internal let companyProfileRecordType = "CompanyProfile"
    
    
    static let databaseQueue = DispatchQueue(label: "com.freelaontap.databaseQueue")
    
    static var companyProfileCache: [CKRecord.ID: CompanyProfile] = [:]
   

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
