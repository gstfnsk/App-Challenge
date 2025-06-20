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
    var cnpj: String
    var whatsappNumber: String
    
    var establishmentType: EstablishmentType
    var companySize: CompanySize
    
    var address: (streetAndNumber: String, neighborhood: String, cityAndState: String)
    var description: String
}

enum EstablishmentType: String, CaseIterable {
    case restaurant
    case bar
    case coffeeshop
    case other
}

enum CompanySize: String, CaseIterable {
    case tiny = "1-10 funcionários"
    case small = "11-20 funcionários"
    case medium = "21-30 funcionários"
    case large = "31-40 funcionários"
    case superLarge = "Mais de 41 funcionários"
}
