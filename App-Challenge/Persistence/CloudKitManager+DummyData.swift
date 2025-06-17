//
//  CloudKitManager+DummyData.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 17/06/25.
//

import Foundation
import CloudKit

extension CloudKitManager {

    func addDummyCompaniesAndJobs() async throws {
        try await throwIfICloudNotAvailable()

        // 1. Empresas do setor F&B em Porto Alegre
        let baseCompanies: [(name: String, type: EstablishmentType, address: String, whatsapp: String)] = [
            ("Boteco do Joaquim", .bar, "R. Joaquim Nabuco, 350 – Cidade Baixa, Porto Alegre, RS", "(51) 3022-7186"),
            ("Capone Drinkeria", .bar, "R. Castro Alves, 447 – Independência, Porto Alegre, RS", "(51) 99597-5442"),
            ("Boteco Matita Perê", .bar, "R. João Alfredo, 626 – Cidade Baixa, Porto Alegre, RS", "(51) 3372-4749"),
            ("Sgt Peppers", .bar, "R. Quintino Bocaiúva, 256 – Moinhos de Vento, Porto Alegre, RS", "(51) 3331-3258"),
            ("Bar Ocidente", .bar, "Av. Oswaldo Aranha, 1879 – Bom Fim, Porto Alegre, RS", "(51) 99999-0000"),
            ("Chalé da Praça XV", .restaurant, "Praça XV de Novembro – Centro Histórico, Porto Alegre, RS", "(51) 99999-1111")
        ]

        var companies: [CompanyProfile] = baseCompanies.map { info in
            CompanyProfile(
                id: UUID(),
                name: info.name,
                establishmentType: info.type,
                cnpj: String(format: "12.345.678/0001-%02d", Int.random(in: 10...99)),
                address: info.address,
                description: "Estabelecimento em Porto Alegre reconhecido localmente.",
                companySize: companySize.small.rawValue,
                photo: "notImplemented",
                whatsappNumber: info.whatsapp,
                email: info.name
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .replacingOccurrences(of: " ", with: "")
                    .lowercased() + "@exemplo.com",
                password: "Senha#123"
            )
        }

        // 2. Salva empresas no CloudKit
        for company in companies {
            try await saveCompany(company)
        }

        // 3. Define posições e salários
        let positions: [(raw: String, salary: Decimal)] = [
            ("garcom", 30), ("bartender", 40),
            ("cozinheiro", 45), ("auxiliarCozinha", 30),
            ("atendenteBalcao", 25), ("hostess", 35),
            ("gerenteBar", 60), ("barista", 30),
            ("sommelier", 50), ("segurancaNoturno", 25)
        ]

        // 4. Cria 10 vagas, 2 por empresa
        var jobCount = 0
        for company in companies {
            for _ in 0..<2 {
                guard jobCount < positions.count else {
                    break
                }
                let pos = positions[jobCount]
                
                let offer = JobOffer(
                    id: UUID(),
                    companyId: company.id,
                    position: JobPosition(rawValue: pos.raw) ?? .other,
                    durationTime: Int.random(in: 4...8),       // duração de 4 a 8 dias
                    startDate: Calendar.current.date(
                        byAdding: .day,
                        value: Int.random(in: 7...30),
                        to: Date()
                    )!,
                    creationDate: Date(),
                    location: company.address,
                    salary: pos.salary,
                    description: "Vaga de \(pos.raw) para atuar em \(company.name).",
                    requirements: "Experiência mínima de 6 meses no setor.",
                    responsibilities: "Atendimento ao cliente e suporte ao time."
                )
                
                try await saveJobOffer(offer)
                jobCount += 1
            }
        }
    }
}
