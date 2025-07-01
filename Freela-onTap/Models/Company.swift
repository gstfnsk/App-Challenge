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
    case restaurant = "Restaurante"
    case bar = "Bar"
    case coffeeshop = "Cafeteria"
    case nightHouse = "Casa noturna"
    case event = "Evento"
    case hotel = "Hotel ou Pousada"
    case other = "Outro"
}

enum CompanySize: String, CaseIterable {
    case tiny = "1-5 funcionários"
    case small = "6-10 funcionários"
    case medium = "11-20 funcionários"
    case large = "21-30 funcionários"
    case superLarge = "31 ou mais"
}
