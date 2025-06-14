//
//  Company.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//

import UIKit

struct CompanyProfile: Identifiable {
    var id: UUID
    var name: String
    var establishmentType: EstablishmentType
    var cnpj: String
    var address: String
    var description: String
    var companySize: String
    var photo: String //Depois trocar para como pretendemos fazer upload da foto
    var whatsappNumber: String
    var email: String
    var password: String
}

enum EstablishmentType: String {
    case restaurant
    case bar
    case coffeeshop
    case other
}

// TODO: usar rawValue pra pegar quantidade de funcionários

enum companySize: String {
    case tiny = "1-10 funcionários"
    case small = "11-20 funcionários"
    case medium = "21-30 funcionários"
    case large = "31-40 funcionários"
    case superLarge = "Mais de 41 funcionários"
}
