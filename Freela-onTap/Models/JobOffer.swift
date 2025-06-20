//
//  JobOffer.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//
import Foundation

struct JobOffer: Identifiable {
    var id: UUID
    var companyId: UUID
    var position: JobPosition
    var durationTime: Int
    var startDate: Date
    let creationDate: Date // imutable
    var location: String
    var salary: Decimal
    var description: String
    var requirements: String
    var responsibilities: String
}

enum JobPosition: String, CaseIterable {
    case waiter = "Garçom"
    case hostess = "Atendente"
    case cashier = "Caixa"
    case busser = "Auxiliar de Garçom"
    case bartender = "Bartender"
    case chef = "Chef"
    case commis = "Auxiliar de Cozinha"
    case buyer = "Comprador"
    case generalManager = "Gerente Geral"
    case floorManager = "Gerente de Salão"
    case other = "Outro"
    
    var iconName: String {
        switch self {
        case .waiter:
            return "figure.walk"
        case .hostess:
            return "person.2"
        case .busser:
            return "hand.raised.fill"
        case .cashier:
            return "dollarsign.circle"
        case .bartender:
            return "wineglass.fill"
        case .chef:
            return "fork.knife.circle.fill"
        case .commis:
            return "square.grid.2x2.fill"
        case .buyer:
            return "cart.badge.plus"
        case .generalManager:
            return "briefcase.fill"
        case .floorManager:
            return "person.2.wave.2.fill"
        case .other:
            return "ellipsis.circle"
        }
    }
}
