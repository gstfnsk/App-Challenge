//
//  CloudKitManager+DummyData.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 17/06/25.
//

import CloudKit
import Foundation

extension CloudKitManager {
    func deleteAllMockData() async throws {
        try await throwIfICloudNotAvailable()
        
        let companies = try await CloudKitManager.shared.fetchAllCompanies()
        
        for company in companies {
            try await CloudKitManager.shared.deleteCompany(company)
        }
        
        let jobs = try await CloudKitManager.shared.fetchAllJobOffers()
        
        for job in jobs {
            try await CloudKitManager.shared.deleteJobOffer(job)
        }
    }
    
    func addMockCompaniesAndJobs() async throws {
        try await throwIfICloudNotAvailable()
        
        let companies: [CompanyProfile] = [
            CompanyProfile(
                id: UUID(),
                name: "Black Falcon Gastrobar",
                cnpj: "23.456.789/0001-66",
                whatsappNumber: "+55 51 99777-6666",
                establishmentType: .restaurant,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua João Alfredo, 1122",
                    neighborhood: "Cidade Baixa",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Gastrobar com ambiente rústico e cardápio inspirado na cozinha mediterrânea com toques contemporâneos.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "Red Koi Sushi Bar",
                
                cnpj: "34.567.890/0001-77",
                whatsappNumber: "+55 51 99666-5555",
                
                establishmentType: .restaurant,
                companySize: .small,
                
                address: (
                    streetAndNumber: "Rua Félix da Cunha, 980",
                    neighborhood: "Moinhos de Vento",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Sushi bar com atmosfera minimalista e cardápio de pratos autorais que combinam tradição japonesa com toques contemporâneos.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "El Cactus Mexican Grill",
                cnpj: "56.789.012/0001-88",
                whatsappNumber: "+55 51 99555-4444",
                establishmentType: .restaurant,
                companySize: .medium,
                address: (
                    streetAndNumber: "Av. Protásio Alves, 1540",
                    neighborhood: "Petrópolis",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Restaurante temático com decoração vibrante, pratos típicos mexicanos e apresentações ao vivo com mariachis nas noites de sexta e sábado.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "JUSSO",
                cnpj: "79.012.345/0001-66",
                whatsappNumber: "+55 51 99333-2223",
                establishmentType: .bar,
                companySize: .small,
                address: (
                    streetAndNumber: "Av. Borges de Medeiros, 743",
                    neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Ponto de encontro criativo, relaxado e aconchegante com drinques e cervejas, além de sanduíches, pizzas e bolos.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "El Avante Lounge",
                cnpj: "81.234.567/0001-88",
                whatsappNumber: "+55 51 99222-1111",
                establishmentType: .bar,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Miguel Tostes, 620",
                    neighborhood: "Rio Branco",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Bar descontraído com ambiente acolhedor, oferecendo refeições no local e retirada na porta. Focado em drinques clássicos e uma seleção de petiscos.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "Doce Amargo Café",
                cnpj: "92.345.678/0001-99",
                whatsappNumber: "+55 51 99111-2222",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Sarmento Leite, 1032",
                    neighborhood: "Cidade Baixa",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Café especializado em lanches, sobremesas e bebidas artesanais, famoso pelo chai latte com especiarias e ambiente acolhedor.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "Cobre Café & Bistrô",
                cnpj: "93.456.789/0001-00",
                whatsappNumber: "+55 51 99000-1111",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua José do Patrocínio, 640",
                    neighborhood: "Cidade Baixa",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Cafeteria moderna com ambiente aconchegante, oferecendo refeições no local e retirada na porta, com destaque para cafés especiais e drinks artesanais."
            ),
            CompanyProfile(
                id: UUID(),
                name: "Café Sombra",
                cnpj: "94.567.890/0001-11",
                whatsappNumber: "+55 51 98999-0000",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Cel. Fernando Machado, 520",
                    neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Cafeteria com atmosfera única, combinando lanches e cafés especiais em um ambiente acolhedor e misterioso.",
            ),
            CompanyProfile(
                id: UUID(),
                name: "Café Sanctus",
                cnpj: "95.678.901/0001-22",
                whatsappNumber: "+55 51 98888-1111",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Dom Sebastião, 120",
                    neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Cafeteria elegante próxima a pontos históricos, oferecendo ambiente tranquilo para refeições no local e cafés especiais.",
            )
        ]
        let jobOffers: [JobOffer] = [
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .waiter,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 18))!,
                salaryBRL: 150,
                description:
                    "O Black Falcon Gastrobar busca um garçom com perfil dinâmico para atendimento em período noturno.",
                qualifications: """
                    - Experiência prévia em atendimento ao público.
                    - Agilidade e boa comunicação.
                    - Disponibilidade para turnos noturnos e finais de semana.
                    """,
                duties: """
                    - Atender os clientes de forma cordial.
                    - Anotar e entregar os pedidos.
                    - Manter a organização das mesas e do salão.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .cook,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 120,
                description:
                    "O Red Koi Sushi Bar está procurando um cozinheiro para auxiliar na preparação de pratos frios e quentes da cozinha japonesa.",
                qualifications:
                    "Experiência prévia na área de cozinha. Conhecimento básico em culinária japonesa será considerado um diferencial.",
                duties:
                    "Preparar os ingredientes, montar os pratos conforme o padrão da casa e manter o ambiente de trabalho limpo."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .hostess,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 18))!,
                salaryBRL: 130,
                description:
                    "Estamos em busca de uma recepcionista para o El Cactus Mexican Grill. Ambiente movimentado, com foco em atendimento de alto padrão.",
                qualifications: """
                    - Boa comunicação verbal.
                    - Experiência prévia com atendimento ao cliente.
                    - Organização e postura profissional.
                    """,
                duties: """
                    - Receber clientes com cordialidade.
                    - Gerenciar reservas.
                    - Controlar a fila de espera.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .bartender,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 29, hour: 19))!,
                salaryBRL: 160,
                description:
                    "O JUSSO está contratando bartender para o turno noturno. Ambiente descontraído e com grande volume de pedidos.",
                qualifications: """
                    - Experiência prévia como bartender.
                    - Conhecimento de drinques clássicos.
                    - Agilidade e atenção aos detalhes.
                    """,
                duties: """
                    - Preparar bebidas conforme o cardápio.
                    - Manter o balcão organizado.
                    - Auxiliar no controle de estoque.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .dishwasher,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 30, hour: 17))!,
                salaryBRL: 100,
                description:
                    "O El Avante Lounge precisa de um lavador de louças para turno da noite. Vaga temporária com possibilidade de efetivação.",
                qualifications: "Organização, agilidade e disponibilidade para trabalhar à noite.",
                duties: """
                    - Lavar pratos, copos e utensílios.
                    - Manter a cozinha limpa.
                    - Apoiar a equipe de cozinha quando necessário.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .barista,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 110,
                description:
                    "O Doce Amargo Café busca um barista apaixonado por café para atendimento no período da tarde.",
                qualifications: """
                    - Experiência com extração de espresso.
                    - Conhecimento em vaporização de leite.
                    - Bom relacionamento interpessoal.
                    """,
                duties: """
                    - Preparar cafés e bebidas especiais.
                    - Atendimento ao balcão.
                    - Manutenção da limpeza da estação de trabalho.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .busser,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 18))!,
                salaryBRL: 110,
                description:
                    "A equipe do Cobre Café & Bistrô está buscando um auxiliar de garçom para dar suporte ao atendimento no salão.",
                qualifications: "Proatividade, disposição física e vontade de aprender.",
                duties: """
                    - Auxiliar no serviço de mesas.
                    - Recolher pratos e talheres.
                    - Manter o salão organizado.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[7].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .cook,
                titleOther: nil,
                durationInHours: 8,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 180,
                description:
                    "O Café Sombra precisa de um cozinheiro para o turno da noite, com foco em pratos rápidos e lanches.",
                qualifications: """
                    - Experiência prévia em cozinha.
                    - Habilidade para trabalhar sob pressão.
                    - Comprometimento com horários.
                    """,
                duties: """
                    - Preparar os pratos do cardápio.
                    - Controlar a qualidade dos alimentos.
                    - Zelar pela limpeza da cozinha.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .hostess,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 29, hour: 18))!,
                salaryBRL: 140,
                description:
                    "O Café Sanctus está contratando recepcionista para atender clientes durante o período da noite em ambiente sofisticado.",
                qualifications: """
                    - Boa comunicação.
                    - Experiência com atendimento ao público.
                    - Organização.
                    """,
                duties: """
                    - Receber os clientes na entrada.
                    - Organizar reservas.
                    - Coordenar a ocupação das mesas.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .bartender,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 30, hour: 19))!,
                salaryBRL: 160,
                description:
                    "O Black Falcon Gastrobar procura bartender para reforçar o time nos finais de semana. Se você gosta de coquetelaria, essa é sua oportunidade.",
                qualifications: "Experiência prévia como bartender. Conhecimento básico de mixologia.",
                duties: """
                    - Preparar drinques e coquetéis.
                    - Manter o balcão limpo e organizado.
                    - Oferecer atendimento ágil aos clientes.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .dishwasher,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 90,
                description:
                    "O Red Koi Sushi Bar precisa de um lavador de louças para cobertura de turno durante o jantar.",
                qualifications: "Pontualidade e atenção à limpeza.",
                duties: "Realizar a lavagem de utensílios, panelas e louças usadas no restaurante."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .manager,
                titleOther: nil,
                durationInHours: 8,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 200,
                description:
                    "O El Cactus Mexican Grill procura gerente de salão com experiência para liderar a equipe durante os turnos de maior movimento.",
                qualifications: """
                    - Experiência prévia em liderança de equipes.
                    - Boa comunicação e gestão de conflitos.
                    - Disponibilidade de horários.
                    """,
                duties: """
                    - Coordenar equipe de salão e bar.
                    - Garantir padrão de qualidade no atendimento.
                    - Monitorar fluxo de clientes e reservas.
                    """
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .waiter,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 18))!,
                salaryBRL: 150,
                description: "Atue como garçom em período noturno, proporcionando atendimento ágil e cordial em ambiente dinâmico.",
                qualifications: """
- Experiência prévia em atendimento ao público.
- Agilidade e boa comunicação.
- Disponibilidade para turnos noturnos e finais de semana.
""",
                duties: """
- Atender os clientes de forma cordial.
- Anotar e entregar os pedidos.
- Manter a organização das mesas e do salão.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .cook,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 120,
                description: "Estamos buscando cozinheiro para auxiliar na preparação de pratos típicos da culinária japonesa, garantindo qualidade e padrão nas receitas.",
                qualifications: "Experiência prévia na área de cozinha. Conhecimento básico em culinária japonesa será considerado um diferencial.",
                duties: "Preparar os ingredientes, montar os pratos conforme o padrão da casa e manter o ambiente de trabalho limpo."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .hostess,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 18))!,
                salaryBRL: 130,
                description: "Procura-se recepcionista para atuar no atendimento ao cliente e organização do salão.",
                qualifications: """
- Boa comunicação verbal.
- Experiência prévia com atendimento ao cliente.
- Organização e postura profissional.
""",
                duties: """
- Receber clientes com cordialidade.
- Gerenciar reservas.
- Controlar a fila de espera.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .bartender,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 29, hour: 19))!,
                salaryBRL: 160,
                description: "Oportunidade para bartender com experiência em coquetelaria, para turno noturno com alto volume de pedidos.",
                qualifications: """
- Experiência prévia como bartender.
- Conhecimento de drinques clássicos.
- Agilidade e atenção aos detalhes.
""",
                duties: """
- Preparar bebidas conforme o cardápio.
- Manter o balcão organizado.
- Auxiliar no controle de estoque.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .dishwasher,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 30, hour: 17))!,
                salaryBRL: 100,
                description: "Você que gosta de manter a cozinha impecável, essa vaga para lavador de louças é para você.",
                qualifications: "Organização, agilidade e disponibilidade para trabalhar à noite.",
                duties: """
- Lavar pratos, copos e utensílios.
- Manter a cozinha limpa.
- Apoiar a equipe de cozinha quando necessário.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .barista,
                titleOther: nil,
                durationInHours: 4,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 110,
                description: "Vaga para barista com paixão por café e experiência no preparo de bebidas especiais.",
                qualifications: """
- Experiência com extração de espresso.
- Conhecimento em vaporização de leite.
- Bom relacionamento interpessoal.
""",
                duties: """
- Preparar cafés e bebidas especiais.
- Atendimento ao balcão.
- Manutenção da limpeza da estação de trabalho.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .busser,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 18))!,
                salaryBRL: 110,
                description: "Buscamos auxiliar de garçom para auxiliar no atendimento e organização do salão.",
                qualifications: "Proatividade, disposição física e vontade de aprender.",
                duties: """
- Auxiliar no serviço de mesas.
- Recolher pratos e talheres.
- Manter o salão organizado.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[7].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 26, hour: 14))!,
                title: .cook,
                titleOther: nil,
                durationInHours: 8,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 27, hour: 17))!,
                salaryBRL: 180,
                description: "Procura-se cozinheiro para preparo de pratos rápidos e lanches durante o turno da noite.",
                qualifications: """
- Experiência prévia em cozinha.
- Habilidade para trabalhar sob pressão.
- Comprometimento com horários.
""",
                duties: """
- Preparar os pratos do cardápio.
- Controlar a qualidade dos alimentos.
- Zelar pela limpeza da cozinha.
"""
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25, hour: 14))!,
                title: .hostess,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 29, hour: 18))!,
                salaryBRL: 140,
                description: "Vaga para recepcionista com foco em atendimento de alto padrão em ambiente sofisticado.",
                qualifications: """
- Boa comunicação.
- Experiência com atendimento ao público.
- Organização.
""",
                duties: """
- Receber os clientes na entrada.
- Organizar reservas.
- Coordenar a ocupação das mesas.
"""
            )
        ]
        
        for company in companies {
            try await CloudKitManager.shared.saveCompany(company)
        }
        
        for jobOffer in jobOffers {
            try await CloudKitManager.shared.saveJobOffer(jobOffer)
        }
    }
}
