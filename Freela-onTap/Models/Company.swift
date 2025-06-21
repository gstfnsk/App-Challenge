//
//  Company.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//

import Foundation

struct CompanyProfile: Identifiable {
    let id: UUID
    var name: String
    var cnpj: String
    var whatsappNumber: String
    var establishmentType: EstablishmentType
    var companySize: CompanySize
    var address: Address
    var description: String
}

struct Address {
    var streetAndNumber: String
    var neighborhood: String
    var cityAndState: String
}

enum EstablishmentType: String, CaseIterable {
    case restaurant = "restaurante"
    case bar = "bar"
    case coffeeshop = "cafeteria"
    case other = "outro"
}

enum CompanySize: String, CaseIterable {
    case tiny = "1-10 funcionários"
    case small = "11-20 funcionários"
    case medium = "21-30 funcionários"
    case large = "31-40 funcionários"
    case superLarge = "Mais de 41 funcionários"
}
