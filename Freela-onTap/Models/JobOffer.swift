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
    case waiter = "garçom"
    case bartender = "barman"
    case chef = "chef"
    case cook = "cozinheiro"
    case hostess = "recepcionista"
    case dishwasher = "lavador de louças"
    case busser = "auxiliar de garçom"
    case barback = "auxiliar de bar"
    case manager = "gerente de salão"
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
