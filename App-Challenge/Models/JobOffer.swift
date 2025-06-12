//
//  JobOffer.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//
import Foundation

struct JobOffer: Identifiable {
    var id: UUID
    var companyId: UUID?
    var position: JobPosition
    var durationTime: Int
    var startDate: Date
    var location: String
    var salary: Decimal
    var description: String
    var requirements: String
    var responsibilities: String
}

enum JobPosition: String {
    case waiter = "garçom"       // Garçom
    case bartender = "barman"  // Barman
    case chef = "chef"        // Chef de cozinha
    case cook = "cozinheiro"         // Cozinheiro
    case hostess = "recepcionista"      // Recepcionista
    case dishwasher = "lavador de roupa"   // Lavador de pratos
    case busser = "auxiliar de garçom"      // Auxiliar de garçom
    case barback = "auxiliar de bar"     // Auxiliar de bar
    case manager = "gerente"      // Gerente
    case barista = "barista"     // Barista
    case other = "outro"       // Outro
}
