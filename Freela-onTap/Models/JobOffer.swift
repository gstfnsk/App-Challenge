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
    var company: CompanyProfile?

    let postedAt: Date // Data de publicação da vaga

    var title: JobPosition // Cargo ou título da vaga
    var titleOther: String?
    var durationInHours: Int // Duração total da oportunidade (em horas)
    var startDate: Date // Data de início do trabalho

    var salaryBRL: Int // Salário ofertado (em Reais)
    var description: String // Detalhes sobre a vaga
    var qualifications: String // Requisitos necessários para o candidato
    var duties: String // Principais responsabilidades da função
}

enum JobPosition: String, CaseIterable {
    case receptionist = "recepcionista"
    case hostess = "atendente"
    case waiter = "garçom"
    case runner = "runner"
    case cashier = "caixa"
    case bartender = "bartender"
    case barback = "barback"
    case sommelier = "sommelier"
    case cook = "cozinheiro"
    case busser = "auxiliar de cozinha"
    case dishwasher = "auxiliar de limpeza"
    case barista = "barista"
    case other = "outro"

    var iconName: String {
        switch self {
        case .receptionist:
            return "coat"
        case .hostess:
            return "person.2"
        case .waiter:
            return "figure.walk"
        case .runner:
            return "hand.raised"
        case .cashier:
            return "dollarsign.circle"
        case .bartender:
            return "wineglass.fill"
        case .barback:
            return "takeoutbag.and.cup.and.straw"
        case .sommelier:
            return "wineglass"
        case .cook:
            return "fork.knife"
        case .busser:
            return "flame"
        case .dishwasher:
            return "bubbles.and.sparkles"
        case .barista:
            return "cup.and.saucer"
        case .other:
            return "ellipsis.circle"
        }
    }
}
