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
    case bartender = "barman"
    case chef = "chef"
    case cook = "cozinheiro"
    case hostess = "recepcionista"
    case dishwasher = "lavador de roupa"
    case busser = "auxiliar de garçom"
    case barback = "auxiliar de bar"
    case manager = "gerente"
    case barista = "barista"
    case other = "outro"
    
    var iconName: String {
        switch self {
        case .waiter:
            return "figure.walk"
        case .bartender:
            return "wineglass"
        case .chef:
            return "takeoutbag.and.cup.and.straw"
        case .cook:
            return "flame"
        case .hostess:
            return "dollarsign.circle"
        case .dishwasher:
            return "drop"
        case .busser:
            return "person.2"
        case .barback:
            return "cube.box"
        case .manager:
            return "person.crop.rectangle"
        case .barista:
            return "cup.and.saucer"
        case .other:
            return "questionmark"
        }
    }
}
