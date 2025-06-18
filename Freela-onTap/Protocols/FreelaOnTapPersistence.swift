//
//  FreelaOnTapPersistence.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 11/06/25.
//

import UIKit

protocol FreelaOnTapPersistence {
    // MARK: - Read Operations
    
    func fetchCompanies() async throws -> [CompanyProfile]
    func fetchCompany(id: UUID) async throws -> CompanyProfile?
    
    func fetchJobOffers() async throws -> [JobOffer]
    func fetchJobOffer(id: UUID) async throws -> JobOffer?
    
    // MARK: - Write Operations
    
    func saveCompany(_ company: CompanyProfile) async throws
    
    func saveJobOffer(_ company: JobOffer) async throws
}
