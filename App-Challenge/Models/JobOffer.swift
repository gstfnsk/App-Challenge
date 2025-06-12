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
    var workSchedule: String
    var startDate: Date
    var endDate: Date
    var location: String
    var salary: Decimal
    var description: String
}

enum JobPosition: String {
    case waiter       // Garçom
    case bartender    // Barman
    case chef         // Chef de cozinha
    case cook         // Cozinheiro
    case hostess      // Recepcionista
    case dishwasher   // Lavador de pratos
    case busser       // Auxiliar de garçom
    case barback      // Auxiliar de bar
    case manager      // Gerente
    case barista      // Barista
    case other        // Outro
}
