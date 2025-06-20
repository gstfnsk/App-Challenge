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
    case waiter = "garçom"
    case hostess = "atendente"
    case cashier = "caixa"
    case busser = "auxiliar de garçom"
    case bartender = "bartender"
    case chef = "chef"
    case barista = "barista"
    case buyer = "comprador"
    case manager = "gerente geral"
    case floorManager = "gerente de salão"
    case dishwasher = "lavador de louças"
    case cook = "cozinheiro"
    case barback = "auxiliar de bar"
    case other = "outro"
    
    var iconName: String {
        switch self {
        case .waiter:
            return "figure.walk"
        case .hostess:
            return "person.2"
        case .cashier:
            return "dollarsign.circle"
        case .busser:
            return "hand.raised.fill"
        case .bartender:
            return "wineglass.fill"
        case .chef:
            return "fork.knife.circle.fill"
        case .barista:
            return "cup.and.saucer.fill"
        case .buyer:
            return "cart.badge.plus"
        case .manager:
            return "briefcase.fill"
        case .floorManager:
            return "person.2.wave.2.fill"
        case .dishwasher:
            return "drop.triangle.fill"
        case .cook:
            return "flame.fill"
        case .barback:
            return "tray.fill"
        case .other:
            return "ellipsis.circle"
        }
    }
}
