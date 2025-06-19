//
//  FreelaOnTapPersistence.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 11/06/25.
//

import UIKit

protocol FOTPersistence:
    FOTPersistence_JobOffer,
    FOTPersistence_CompanyProfile
{}


protocol FOTPersistence_CompanyProfile {
    func fetchAllCompanies() async throws -> [CompanyProfile]
    func fetchCompany(id: UUID) async throws -> CompanyProfile?
    
    func saveCompany(_ company: CompanyProfile) async throws
    func deleteCompany(companyUUID id: UUID) async throws
}

protocol FOTPersistence_JobOffer {
    func fetchAllJobOffers() async throws -> [JobOffer]
    func fetchJobOffer(id: UUID) async throws -> JobOffer?
    
    
    func saveJobOffer(_ jobOffer: JobOffer) async throws
    func deleteJobOffer(jobOfferUUID id: UUID) async throws
}
