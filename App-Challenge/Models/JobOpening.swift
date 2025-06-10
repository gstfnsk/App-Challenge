//
//  JobOpening.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//
import Foundation

struct JobOpening {
    let companyId: UUID // O tipo de estabelecimento vai ser puxado pela empresa
    let position: Position
    let workSchedule: String
    let startDate: Date
    let endDate: Date
    let location: String
    let salary: Decimal
    let description: String
}

enum Position: String {
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

