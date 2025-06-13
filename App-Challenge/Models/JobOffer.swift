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

enum JobPosition: String {
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
}
