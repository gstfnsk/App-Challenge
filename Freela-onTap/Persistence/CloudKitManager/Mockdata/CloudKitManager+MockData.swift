//
//  CloudKitManager+DummyData.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 17/06/25.
//

import CloudKit
import Foundation

extension CloudKitManager {
    func createMockDataIfNeeded() async {
        let companyList = try? await fetchAllCompanies()

        guard companyList?.first != nil else {
            try? await deleteAllMockData()
            try? await addMockCompaniesAndJobs()
            print("Mock data added successfully!")
            return
        }
    }

    func deleteAllMockData() async throws {
        try await throwIfICloudNotAvailable()

        var query = CKQuery(recordType: companyProfileRecordType, predicate: CloudKitManager.allWithIdPredicate)
        var (matchResults, _) = try await publicDB.records(matching: query)

        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                try await CloudKitManager.shared.deleteCompany(companyUUID: UUID(uuidString: record["id"] as! String)!)
            case .failure(let error):
                throw error
            }
        }

        query = CKQuery(recordType: jobOfferRecordType, predicate: CloudKitManager.allWithIdPredicate)
        (matchResults, _) = try await publicDB.records(matching: query)

        for (_, result) in matchResults {
            switch result {
            case .success(let record):
                try await CloudKitManager.shared.deleteJobOffer(
                    jobOfferUUID: UUID(uuidString: record["id"] as! String)!
                )
            case .failure(let error):
                throw error
            }
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
                qualifications: """
                    Experiência prévia na área de cozinha. Conhecimento básico em culinária japonesa será considerado um diferencial.
                    """,
                duties: """
                    Preparar os ingredientes, montar os pratos conforme o padrão da casa e manter o ambiente de trabalho limpo.
                    """
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
                qualifications: """
                    Organização, agilidade e disponibilidade para trabalhar à noite.
                    """,
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
                    "A equipe do Cobre Café & Bistrô está buscando um auxiliar de cozinha para dar suporte ao atendimento no salão.",
                qualifications: """
                    Proatividade, disposição física e vontade de aprender.
                    """,
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
            //            // 1. Manager for Black Falcon Gastrobar
            //            JobOffer(
            //                id: UUID(),
            //                companyId: companies[0].id,
            //                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 22, hour: 10))!,
            //                title: .manager,
            //                titleOther: nil,
            //                durationInHours: 8,
            //                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 1, hour: 16))!,
            //                salaryBRL: 320,
            //                description:
            //                    "O Black Falcon Gastrobar busca um Gerente Geral para liderar a equipe e supervisionar todas as operações do restaurante.",
            //                qualifications: """
            //                    - Experiência comprovada em gestão de restaurantes.
            //                    - Excelentes habilidades de liderança e comunicação.
            //                    - Conhecimento em gestão financeira e de estoque.
            //                    """,
            //                duties: """
            //                    - Gerenciar a equipe de salão e cozinha.
            //                    - Garantir a satisfação do cliente e a qualidade do serviço.
            //                    - Controlar custos operacionais e otimizar a lucratividade.
            //                    """
            //            ),
            // 2. Chef for Red Koi Sushi Bar
            //            JobOffer(
            //                id: UUID(),
            //                companyId: companies[1].id,
            //                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 23, hour: 11))!,
            //                title: .chef,
            //                titleOther: nil,
            //                durationInHours: 8,
            //                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 2, hour: 17))!,
            //                salaryBRL: 300,
            //                description:
            //                    "Procuramos um Chef de Cozinha com especialização em culinária japonesa para inovar nosso cardápio no Red Koi Sushi Bar.",
            //                qualifications: """
            //                    - Vasta experiência como Chef, preferencialmente em restaurantes japoneses.
            //                    - Criatividade para desenvolvimento de novos pratos.
            //                    - Capacidade de liderar a equipe de cozinha.
            //                    """,
            //                duties: """
            //                    - Comandar a preparação de todos os pratos.
            //                    - Realizar o controle de qualidade dos insumos e preparos.
            //                    - Treinar e supervisionar os cozinheiros e auxiliares.
            //                    """
            //            ),
            //            // 3. Buyer for El Cactus Mexican Grill
            //            JobOffer(
            //                id: UUID(),
            //                companyId: companies[2].id,
            //                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 24, hour: 9))!,
            //                title: .buyer,
            //                titleOther: nil,
            //                durationInHours: 6,
            //                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 30, hour: 10))!,
            //                salaryBRL: 180,
            //                description:
            //                    "Vaga para Comprador no El Cactus Mexican Grill, responsável pela aquisição de todos os insumos e negociação com fornecedores.",
            //                qualifications: """
            //                    - Experiência em compras para o setor de alimentos e bebidas.
            //                    - Habilidade de negociação e relacionamento com fornecedores.
            //                    - Organização e controle de planilhas.
            //                    """,
            //                duties: """
            //                    - Realizar cotações e efetuar a compra de produtos.
            //                    - Controlar os níveis de estoque para evitar rupturas ou excessos.
            //                    - Buscar novos fornecedores e otimizar custos.
            //                    """
            //            ),
            //            // 4. Floor Manager for JUSSO
            //            JobOffer(
            //                id: UUID(),
            //                companyId: companies[3].id,
            //                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 23, hour: 15))!,
            //                title: .floorManager,
            //                titleOther: nil,
            //                durationInHours: 7,
            //                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 3, hour: 18))!,
            //                salaryBRL: 200,
            //                description:
            //                    "O bar JUSSO contrata Gerente de Salão para coordenar o serviço noturno e garantir uma experiência excelente aos clientes.",
            //                qualifications: """
            //                    - Experiência na liderança de equipes de atendimento em bares ou restaurantes.
            //                    - Postura proativa e habilidade para resolver conflitos.
            //                    - Excelente comunicação interpessoal.
            //                    """,
            //                duties: """
            //                    - Supervisionar o trabalho de garçons, bussers e bartenders.
            //                    - Gerenciar o fluxo de clientes e a organização do salão.
            //                    - Assegurar a qualidade do atendimento e dos produtos servidos.
            //                    """
            //            ),
            //            // 5. Barback for El Avante Lounge
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 22, hour: 18))!,
                title: .barback,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 19))!,
                salaryBRL: 100,
                description:
                    "O El Avante Lounge precisa de um Auxiliar de Bar (Barback) ágil para dar suporte à equipe de bartenders durante o pico de movimento.",
                qualifications: """
                    - Agilidade, proatividade e organização.
                    - Capacidade de trabalhar em um ambiente de ritmo acelerado.
                    - Experiência prévia é um diferencial, mas não obrigatória.
                    """,
                duties: """
                    - Manter o estoque de bebidas e insumos do bar abastecido.
                    - Realizar a limpeza e organização do balcão e equipamentos.
                    - Auxiliar os bartenders na preparação de drinks e no atendimento.
                    """
            ),
            // 6. Cashier for Cobre Café & Bistrô
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 24, hour: 13))!,
                title: .cashier,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 29, hour: 14))!,
                salaryBRL: 110,
                description:
                    "Vaga para Caixa no Cobre Café & Bistrô. Buscamos um profissional atencioso e organizado para o turno da tarde.",
                qualifications: """
                    - Experiência com operação de caixa e sistemas de PDV.
                    - Atenção aos detalhes e habilidade com números.
                    - Simpatia e boa comunicação com o público.
                    """,
                duties: """
                    - Processar pagamentos de clientes (dinheiro, cartão, pix).
                    - Realizar a abertura e o fechamento do caixa.
                    - Emitir notas fiscais e manter o controle financeiro do dia.
                    """
            ),
            // 1. Barista for Café Sombra (Morning Shift)
            JobOffer(
                id: UUID(),
                companyId: companies[7].id,  // Café Sombra
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 21, hour: 17))!,
                title: .barista,
                titleOther: nil,
                durationInHours: 7,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 28, hour: 8))!,  // 08:00 AM start
                salaryBRL: 140,
                description:
                    "O Café Sombra está contratando um barista para o turno da manhã, focado em preparar cafés especiais e atender nossa clientela matutina.",
                qualifications: """
                    - Experiência prévia como barista.
                    - Paixão por café e habilidade em latte art é um diferencial.
                    - Pontualidade e disposição para trabalhar em horários matutinos.
                    """,
                duties: """
                    - Abrir a cafeteria e preparar os equipamentos.
                    - Preparar e servir bebidas à base de café.
                    - Manter a limpeza e organização da estação de trabalho.
                    """
            ),
            // 2. Cook for Black Falcon Gastrobar (Prep Shift)
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,  // Black Falcon Gastrobar
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 21, hour: 17))!,
                title: .cook,
                titleOther: nil,
                durationInHours: 8,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 30, hour: 9))!,  // 09:00 AM start
                salaryBRL: 200,
                description:
                    "Vaga para cozinheiro no Black Falcon Gastrobar para o turno de preparação (mise en place), garantindo que todos os insumos estejam prontos para os serviços de almoço e jantar.",
                qualifications: """
                    - Experiência em preparação de alimentos (mise en place).
                    - Agilidade e organização para seguir as fichas técnicas.
                    - Capacidade de trabalhar de forma independente.
                    """,
                duties: """
                    - Preparar vegetais, carnes e molhos conforme o cardápio.
                    - Manter o controle de validade e a organização do estoque.
                    - Garantir a higiene e limpeza da área de preparação.
                    """
            ),
            // 3. Busser for Doce Amargo Café (Morning/Lunch Rush)
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,  // Doce Amargo Café
                postedAt: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 21, hour: 17))!,
                title: .busser,
                titleOther: nil,
                durationInHours: 6,
                startDate: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 1, hour: 10))!,  // 10:00 AM start
                salaryBRL: 90,
                description:
                    "O Doce Amargo Café busca um auxiliar de salão para dar suporte durante o movimento da manhã e almoço.",
                qualifications: """
                    - Proatividade e boa disposição física.
                    - Não é necessário ter experiência prévia.
                    - Bom trabalho em equipe.
                    """,
                duties: """
                    - Limpar e montar as mesas rapidamente.
                    - Levar louça suja para a copa.
                    - Auxiliar os garçons e baristas quando necessário.
                    """
            )
        ]

        print("There will be added \(companies.count) companies and \(jobOffers.count) job offers.")

        for company in companies {
            do {
                try await CloudKitManager.shared.saveCompany(company)
            } catch {
                print("Erro ao salvar empresa '\(company.name)': \(error.localizedDescription)")
            }
        }

        for jobOffer in jobOffers {
            do {
                try await CloudKitManager.shared.saveJobOffer(jobOffer)
            } catch {
                print("Erro ao salvar vaga '\(jobOffer.title.rawValue)': \(error.localizedDescription)")
            }
        }

        print("All data as added!")
    }
}
