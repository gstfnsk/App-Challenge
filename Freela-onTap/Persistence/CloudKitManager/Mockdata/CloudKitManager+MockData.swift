import CloudKit
import Foundation

extension CloudKitManager {
    /// A static summary of the mock data that will be created.
    static var mockDataSummary: (companyCount: Int, jobCount: Int) {
        let companies = CloudKitManager.shared.getMockCompanies()
        let jobOffers = CloudKitManager.shared.getMockJobOffers(for: companies)
        return (companies.count, jobOffers.count)
    }

    /// Deletes all mock data while reporting progress.
    /// - Parameter progressHandler: A closure that receives progress (0.0 to 0.5) and a status string.
    func deleteAllMockData(progressHandler: @escaping (Double, String) -> Void) async throws {
        try await throwIfICloudNotAvailable()

        // Fetch all records first to get a total count for progress calculation
        let companyQuery = CKQuery(recordType: companyProfileRecordType, predicate: CloudKitManager.allWithIdPredicate)
        let (companyMatchResults, _) = try await publicDB.records(matching: companyQuery)
        let companyRecordsToDelete = companyMatchResults.compactMap { try? $0.1.get() }

        let jobQuery = CKQuery(recordType: jobOfferRecordType, predicate: CloudKitManager.allWithIdPredicate)
        let (jobMatchResults, _) = try await publicDB.records(matching: jobQuery)
        let jobRecordsToDelete = jobMatchResults.compactMap { try? $0.1.get() }

        let totalItemsToDelete = companyRecordsToDelete.count + jobRecordsToDelete.count
        var itemsDeleted = 0

        // Delete Companies
        for record in companyRecordsToDelete {
            guard let idString = record["id"] as? String, let uuid = UUID(uuidString: idString) else { continue }
            try await CloudKitManager.shared.deleteCompany(companyUUID: uuid)

            itemsDeleted += 1
            let progress = 0.5 * (Double(itemsDeleted) / Double(totalItemsToDelete))
            let status = "Deleting item \(itemsDeleted) of \(totalItemsToDelete)..."
            progressHandler(progress, status)
        }

        // Delete Job Offers
        for record in jobRecordsToDelete {
            guard let idString = record["id"] as? String, let uuid = UUID(uuidString: idString) else { continue }
            try await CloudKitManager.shared.deleteJobOffer(jobOfferUUID: uuid)

            itemsDeleted += 1
            let progress = 0.5 * (Double(itemsDeleted) / Double(totalItemsToDelete))
            let status = "Deleting item \(itemsDeleted) of \(totalItemsToDelete)..."
            progressHandler(progress, status)
        }
    }

    /// Adds all mock data while reporting progress.
    /// - Parameter progressHandler: A closure that receives progress (0.5 to 1.0) and a status string.
    func addMockCompaniesAndJobs(progressHandler: @escaping (Double, String) -> Void) async throws {
        try await throwIfICloudNotAvailable()

        let companies = getMockCompanies()
        let jobOffers = getMockJobOffers(for: companies)

        let totalItemsToAdd = companies.count + jobOffers.count
        var itemsAdded = 0

        // Add Companies
        for company in companies {
            try await CloudKitManager.shared.saveCompany(company)
            itemsAdded += 1
            // Progress for this section is from 0.5 to 1.0
            let progress = 0.5 + (0.5 * (Double(itemsAdded) / Double(totalItemsToAdd)))
            let status = "Adding item \(itemsAdded) of \(totalItemsToAdd)..."
            progressHandler(progress, status)
        }

        // Add Job Offers
        for jobOffer in jobOffers {
            try await CloudKitManager.shared.saveJobOffer(jobOffer)
            itemsAdded += 1
            // Progress for this section is from 0.5 to 1.0
            let progress = 0.5 + (0.5 * (Double(itemsAdded) / Double(totalItemsToAdd)))
            let status = "Adding item \(itemsAdded) of \(totalItemsToAdd)..."
            progressHandler(progress, status)
        }
    }

    // Helper functions to keep the main logic clean
    private func getMockCompanies() -> [CompanyProfile] {
        return [
            CompanyProfile(
                id: UUID(),
                name: "Black Falcon Gastrobar",
                cnpj: "23.456.789/0001-66",
                whatsappNumber: "+55 51 99777-6666",
                establishmentType: .restaurant,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua João Alfredo, 1122", neighborhood: "Cidade Baixa",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Gastrobar com ambiente rústico e cardápio inspirado na cozinha mediterrânea com toques contemporâneos."
            ),
            CompanyProfile(
                id: UUID(),
                name: "Red Koi Sushi Bar",
                cnpj: "34.567.890/0001-77",
                whatsappNumber: "+55 51 99666-5555",
                establishmentType: .restaurant,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Félix da Cunha, 980", neighborhood: "Moinhos de Vento",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Sushi bar com atmosfera minimalista e cardápio de pratos autorais que combinam tradição japonesa com toques contemporâneos."
            ),
            CompanyProfile(
                id: UUID(),
                name: "El Cactus Mexican Grill",
                cnpj: "56.789.012/0001-88",
                whatsappNumber: "+55 51 99555-4444",
                establishmentType: .restaurant,
                companySize: .medium,
                address: (
                    streetAndNumber: "Av. Protásio Alves, 1540", neighborhood: "Petrópolis",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Restaurante temático com decoração vibrante, pratos típicos mexicanos e apresentações ao vivo com mariachis nas noites de sexta e sábado."
            ),
            CompanyProfile(
                id: UUID(),
                name: "JUSSO",
                cnpj: "79.012.345/0001-66",
                whatsappNumber: "+55 51 99333-2223",
                establishmentType: .bar,
                companySize: .small,
                address: (
                    streetAndNumber: "Av. Borges de Medeiros, 743", neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Ponto de encontro criativo, relaxado e aconchegante com drinques e cervejas, além de sanduíches, pizzas e bolos."
            ),
            CompanyProfile(
                id: UUID(),
                name: "El Avante Lounge",
                cnpj: "81.234.567/0001-88",
                whatsappNumber: "+55 51 99222-1111",
                establishmentType: .bar,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Miguel Tostes, 620", neighborhood: "Rio Branco",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Bar descontraído com ambiente acolhedor, oferecendo refeições no local e retirada na porta. Focado em drinques clássicos e uma seleção de petiscos."
            ),
            CompanyProfile(
                id: UUID(),
                name: "Doce Amargo Café",
                cnpj: "92.345.678/0001-99",
                whatsappNumber: "+55 51 99111-2222",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Sarmento Leite, 1032", neighborhood: "Cidade Baixa",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Café especializado em lanches, sobremesas e bebidas artesanais, famoso pelo chai latte com especiarias e ambiente acolhedor."
            ),
            CompanyProfile(
                id: UUID(),
                name: "Cobre Café & Bistrô",
                cnpj: "93.456.789/0001-00",
                whatsappNumber: "+55 51 99000-1111",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua José do Patrocínio, 640", neighborhood: "Cidade Baixa",
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
                    streetAndNumber: "Rua Cel. Fernando Machado, 520", neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Cafeteria com atmosfera única, combinando lanches e cafés especiais em um ambiente acolhedor e misterioso."
            ),
            CompanyProfile(
                id: UUID(),
                name: "Café Sanctus",
                cnpj: "95.678.901/0001-22",
                whatsappNumber: "+55 51 98888-1111",
                establishmentType: .coffeeshop,
                companySize: .small,
                address: (
                    streetAndNumber: "Rua Dom Sebastião, 120", neighborhood: "Centro Histórico",
                    cityAndState: "Porto Alegre - RS"
                ),
                description:
                    "Cafeteria elegante próxima a pontos históricos, oferecendo ambiente tranquilo para refeições no local e cafés especiais."
            ),
        ]
    }

    private func getMockJobOffers(for companies: [CompanyProfile]) -> [JobOffer] {
        // Lista expandida para garantir pelo menos 5 vagas de cada tipo.
        return [

            // MARK: - Waiter Jobs (Garçom)
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(25, 14),
                title: .waiter,
                durationInHours: 6,
                startDate: date(27, 18),
                salaryBRL: 150,
                description:
                    "O Black Falcon Gastrobar busca um garçom com perfil dinâmico para atendimento em período noturno.",
                qualifications: "- Experiência prévia\n- Agilidade e boa comunicação",
                duties: "- Atender clientes\n- Anotar e entregar pedidos"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(25, 10),
                title: .waiter,
                durationInHours: 8,
                startDate: date(28, 19),
                salaryBRL: 165,
                description:
                    "Vaga para garçom/garçonete para o salão principal do El Cactus, com foco em serviço de alta qualidade para famílias e grupos.",
                qualifications: "- Simpatia e proatividade\n- Experiência com sistema de pedidos",
                duties: "- Servir mesas\n- Venda sugestiva de pratos e bebidas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(24, 16),
                title: .waiter,
                durationInHours: 7,
                startDate: date(27, 20),
                salaryBRL: 155,
                description:
                    "JUSSO contrata garçom para o turno da noite. Ambiente descontraído e com grande volume de clientes.",
                qualifications: "- Experiência em bares\n- Boa comunicação",
                duties: "- Atendimento no salão e mesas externas\n- Manter a organização"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(23, 11),
                title: .waiter,
                durationInHours: 5,
                startDate: date(29, 12),
                salaryBRL: 125,
                description: "Vaga para serviço de almoço no Black Falcon. Horário de pico, necessário agilidade.",
                qualifications: "- Disponibilidade diurna\n- Experiência com alto fluxo",
                duties: "- Atender mesas no almoço executivo\n- Montagem e desmontagem de mesas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(22, 18),
                title: .waiter,
                durationInHours: 6,
                startDate: date(30, 19),
                salaryBRL: 180,
                description:
                    "Red Koi Sushi Bar busca garçom com conhecimento em vinhos e saquês para um serviço diferenciado.",
                qualifications: "- Conhecimento em bebidas é um diferencial\n- Postura profissional",
                duties: "- Apresentar o cardápio\n- Servir com elegância e técnica"
            ),

            // MARK: - Hostess Jobs (Atendente/Recepcionista de Salão)
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(25, 14),
                title: .hostess,
                durationInHours: 6,
                startDate: date(28, 18),
                salaryBRL: 130,
                description:
                    "Hostess para o El Cactus Mexican Grill. Ambiente movimentado, com foco em atendimento de alto padrão.",
                qualifications: "- Boa comunicação verbal\n- Organização e postura",
                duties: "- Receber clientes\n- Gerenciar reservas e fila de espera"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: date(25, 14),
                title: .hostess,
                durationInHours: 6,
                startDate: date(29, 18),
                salaryBRL: 140,
                description:
                    "O Café Sanctus contrata hostess para atender clientes durante a noite em ambiente sofisticado.",
                qualifications: "- Experiência com atendimento ao público\n- Organização",
                duties: "- Receber os clientes na entrada\n- Coordenar a ocupação das mesas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(24, 12),
                title: .hostess,
                durationInHours: 5,
                startDate: date(28, 19),
                salaryBRL: 120,
                description: "Hostess para o Black Falcon Gastrobar, responsável pelo primeiro contato com o cliente.",
                qualifications: "- Simpatia contagiante\n- Habilidade com tablets para gestão de fila",
                duties: "- Acolher os clientes\n- Gerenciar a lista de espera digital"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(23, 17),
                title: .hostess,
                durationInHours: 7,
                startDate: date(27, 19),
                salaryBRL: 150,
                description:
                    "Red Koi Sushi Bar busca hostess para recepção e confirmação de reservas por telefone e WhatsApp.",
                qualifications: "- Excelente comunicação escrita e verbal\n- Discrição e profissionalismo",
                duties: "- Confirmar reservas\n- Recepcionar clientes no salão"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(22, 15),
                title: .hostess,
                durationInHours: 6,
                startDate: date(30, 18),
                salaryBRL: 135,
                description: "JUSSO precisa de um(a) hostess para organizar o fluxo de entrada nas noites de evento.",
                qualifications: "- Proatividade\n- Capacidade de trabalhar sob pressão",
                duties: "- Organizar a entrada\n- Direcionar clientes para mesas ou bar"
            ),

            // MARK: - Cook Jobs (Cozinheiro)
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(26, 14),
                title: .cook,
                durationInHours: 4,
                startDate: date(27, 17),
                salaryBRL: 120,
                description:
                    "Red Koi Sushi Bar procura cozinheiro para auxiliar na preparação de pratos frios e quentes da cozinha japonesa.",
                qualifications:
                    "Experiência prévia na área de cozinha. Conhecimento básico em culinária japonesa será um diferencial.",
                duties:
                    "Preparar os ingredientes, montar os pratos conforme o padrão da casa e manter o ambiente de trabalho limpo."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[7].id,
                postedAt: date(26, 14),
                title: .cook,
                durationInHours: 8,
                startDate: date(27, 17),
                salaryBRL: 180,
                description:
                    "O Café Sombra precisa de um cozinheiro para o turno da noite, com foco em pratos rápidos e lanches.",
                qualifications: "- Experiência prévia em cozinha\n- Habilidade para trabalhar sob pressão",
                duties: "- Preparar os pratos do cardápio\n- Controlar a qualidade dos alimentos"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(21, 17),
                title: .cook,
                durationInHours: 8,
                startDate: date(30, 9),
                salaryBRL: 200,
                description:
                    "Vaga para cozinheiro no Black Falcon Gastrobar para o turno de preparação (mise en place).",
                qualifications: "- Experiência em preparação de alimentos\n- Agilidade e organização",
                duties: "- Preparar vegetais, carnes e molhos\n- Manter o controle de validade"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(24, 9),
                title: .cook,
                durationInHours: 8,
                startDate: date(28, 16),
                salaryBRL: 190,
                description:
                    "Cozinheiro com experiência em grelhados e culinária mexicana para El Cactus Mexican Grill.",
                qualifications: "- Experiência com chapa e grelha\n- Conhecimento em comida mexicana",
                duties: "- Preparar carnes, fajitas e outros pratos quentes\n- Manter a limpeza da praça"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(23, 10),
                title: .cook,
                durationInHours: 7,
                startDate: date(29, 17),
                salaryBRL: 175,
                description: "JUSSO contrata cozinheiro para a chapa de lanches e pizzas.",
                qualifications: "- Experiência com lanches e pizzas\n- Rapidez na execução",
                duties: "- Montagem e finalização de lanches\n- Controle de insumos da sua praça"
            ),

            // MARK: - Barista Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: date(26, 14),
                title: .barista,
                durationInHours: 4,
                startDate: date(27, 17),
                salaryBRL: 110,
                description:
                    "O Doce Amargo Café busca um barista apaixonado por café para atendimento no período da tarde.",
                qualifications: "- Experiência com extração de espresso\n- Conhecimento em vaporização de leite",
                duties: "- Preparar cafés e bebidas especiais\n- Atendimento ao balcão"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[7].id,
                postedAt: date(21, 17),
                title: .barista,
                durationInHours: 7,
                startDate: date(28, 8),
                salaryBRL: 140,
                description:
                    "O Café Sombra está contratando um barista para o turno da manhã, focado em preparar cafés especiais.",
                qualifications: "- Paixão por café e habilidade em latte art\n- Pontualidade",
                duties: "- Abrir a cafeteria e preparar os equipamentos\n- Preparar e servir bebidas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: date(25, 8),
                title: .barista,
                durationInHours: 8,
                startDate: date(29, 9),
                salaryBRL: 150,
                description:
                    "Barista com experiência em métodos de extração (V60, Aeropress) para o Cobre Café & Bistrô.",
                qualifications: "- Conhecimento em cafés especiais\n- Bom relacionamento interpessoal",
                duties: "- Preparo de cafés em diferentes métodos\n- Explicar sobre os grãos aos clientes"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: date(24, 13),
                title: .barista,
                durationInHours: 6,
                startDate: date(28, 14),
                salaryBRL: 130,
                description:
                    "Café Sanctus busca barista para o turno da tarde, com foco em atendimento e preparo de bebidas clássicas.",
                qualifications: "- Simpatia e agilidade no atendimento\n- Experiência com máquina de espresso",
                duties: "- Operar a máquina de café\n- Manter o balcão limpo e organizado"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: date(23, 9),
                title: .barista,
                durationInHours: 6,
                startDate: date(27, 8),
                salaryBRL: 125,
                description:
                    "Vaga para barista no turno de abertura do Doce Amargo Café. Foco em agilidade para o movimento da manhã.",
                qualifications: "- Experiência com alto volume\n- Pontualidade é essencial",
                duties: "- Preparo rápido de cafés para viagem\n- Organização inicial da estação"
            ),

            // MARK: - Bartender Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(26, 14),
                title: .bartender,
                durationInHours: 6,
                startDate: date(29, 19),
                salaryBRL: 160,
                description:
                    "O JUSSO está contratando bartender para o turno noturno. Ambiente descontraído e com grande volume de pedidos.",
                qualifications: "- Experiência prévia como bartender\n- Conhecimento de drinques clássicos",
                duties: "- Preparar bebidas conforme o cardápio\n- Manter o balcão organizado"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(25, 15),
                title: .bartender,
                durationInHours: 8,
                startDate: date(28, 18),
                salaryBRL: 190,
                description: "Bartender com foco em coquetelaria autoral para o Black Falcon Gastrobar.",
                qualifications: "- Criatividade e conhecimento de mixologia\n- Experiência comprovada",
                duties: "- Preparar coquetéis clássicos e autorais\n- Ajudar no desenvolvimento da carta"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(24, 18),
                title: .bartender,
                durationInHours: 7,
                startDate: date(27, 19),
                salaryBRL: 180,
                description:
                    "El Avante Lounge busca bartender para o bar principal. Foco em drinques clássicos e atendimento premium.",
                qualifications: "- Excelente apresentação e comunicação\n- Conhecimento de destilados",
                duties: "- Atender clientes no balcão\n- Preparar bebidas com precisão"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(23, 16),
                title: .bartender,
                durationInHours: 6,
                startDate: date(30, 20),
                salaryBRL: 170,
                description: "Vaga para bartender no El Cactus. Especialista em margaritas, tequilas e mezcales.",
                qualifications: "- Conhecimento em destilados de agave\n- Agilidade",
                duties: "- Preparar margaritas e outros drinques temáticos\n- Manter a praça do bar"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: date(22, 17),
                title: .bartender,
                durationInHours: 5,
                startDate: date(29, 18),
                salaryBRL: 150,
                description:
                    "Cobre Café & Bistrô contrata bartender para o happy hour, com foco em drinks com café e aperitivos.",
                qualifications: "- Interesse em mixologia com café\n- Proatividade",
                duties: "- Preparar drinks do happy hour\n- Organizar o bar para o serviço noturno"
            ),

            // MARK: - Dishwasher Jobs (Auxiliar de Limpeza)
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(25, 14),
                title: .dishwasher,
                durationInHours: 4,
                startDate: date(30, 17),
                salaryBRL: 100,
                description:
                    "O El Avante Lounge precisa de um lavador de louças para turno da noite. Vaga com possibilidade de efetivação.",
                qualifications: "Organização, agilidade e disponibilidade para trabalhar à noite.",
                duties: "- Lavar pratos, copos e utensílios\n- Manter a cozinha limpa."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(24, 10),
                title: .dishwasher,
                durationInHours: 8,
                startDate: date(28, 16),
                salaryBRL: 120,
                description: "Auxiliar de limpeza para a cozinha principal do Black Falcon. Turno integral.",
                qualifications: "- Disposição e responsabilidade\n- Experiência é um diferencial",
                duties: "- Operar máquina de lavar louças\n- Limpeza geral da cozinha"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(23, 11),
                title: .dishwasher,
                durationInHours: 6,
                startDate: date(27, 18),
                salaryBRL: 110,
                description:
                    "Red Koi precisa de um auxiliar de limpeza para a copa. Foco na lavagem de louças delicadas.",
                qualifications: "- Cuidado e atenção aos detalhes\n- Organização",
                duties: "- Lavagem manual de itens delicados\n- Organização de pratos e talheres"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(22, 14),
                title: .dishwasher,
                durationInHours: 7,
                startDate: date(29, 17),
                salaryBRL: 115,
                description: "Vaga para auxiliar de limpeza no El Cactus. Grande volume de louças, trabalho em equipe.",
                qualifications: "- Agilidade e bom condicionamento físico\n- Trabalho em equipe",
                duties: "- Lavagem e organização de louças e utensílios\n- Suporte à equipe de cozinha"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: date(21, 16),
                title: .dishwasher,
                durationInHours: 5,
                startDate: date(30, 14),
                salaryBRL: 105,
                description: "Doce Amargo Café busca auxiliar de limpeza para o turno da tarde.",
                qualifications: "- Proatividade e organização\n- Não precisa de experiência",
                duties: "- Limpeza de xícaras, pires e talheres\n- Limpeza geral do ambiente da copa"
            ),

            // ... E assim por diante para todas as outras categorias ...
            // MARK: - Busser Jobs (Auxiliar de Cozinha/Salão)
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: date(25, 14),
                title: .busser,
                durationInHours: 6,
                startDate: date(28, 18),
                salaryBRL: 110,
                description:
                    "A equipe do Cobre Café & Bistrô está buscando um auxiliar de cozinha para dar suporte ao atendimento no salão.",
                qualifications: "Proatividade, disposição física e vontade de aprender.",
                duties: "- Auxiliar no serviço de mesas\n- Recolher pratos e talheres."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: date(21, 17),
                title: .busser,
                durationInHours: 6,
                startDate: date(29, 10),
                salaryBRL: 90,
                description:
                    "O Doce Amargo Café busca um auxiliar de salão para dar suporte durante o movimento da manhã e almoço.",
                qualifications: "- Proatividade e boa disposição física\n- Não é necessário ter experiência prévia.",
                duties: "- Limpar e montar as mesas rapidamente\n- Levar louça suja para a copa."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(24, 15),
                title: .busser,
                durationInHours: 7,
                startDate: date(27, 19),
                salaryBRL: 115,
                description: "Busser / Cumim para o Black Falcon. Suporte direto aos garçons em um salão movimentado.",
                qualifications: "- Agilidade e atenção\n- Boa comunicação com a equipe",
                duties: "- Retirar pratos sujos\n- Repor talheres e guardanapos"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(23, 18),
                title: .busser,
                durationInHours: 8,
                startDate: date(28, 18),
                salaryBRL: 120,
                description: "El Cactus busca auxiliar de salão para os finais de semana. Grande movimento.",
                qualifications: "- Disponibilidade aos finais de semana\n- Muita disposição",
                duties: "- Manter o salão limpo e organizado\n- Polir talheres e copos"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(22, 19),
                title: .busser,
                durationInHours: 6,
                startDate: date(30, 19),
                salaryBRL: 110,
                description:
                    "Auxiliar de cozinha para o El Avante Lounge, com foco no suporte à preparação de petiscos.",
                qualifications: "- Noções básicas de cozinha\n- Organização e limpeza",
                duties: "- Pequenos cortes e preparações\n- Montagem de pratos frios"
            ),

            // MARK: - Cashier Jobs (Caixa)
            JobOffer(
                id: UUID(),
                companyId: companies[6].id,
                postedAt: date(24, 13),
                title: .cashier,
                durationInHours: 6,
                startDate: date(29, 14),
                salaryBRL: 110,
                description:
                    "Vaga para Caixa no Cobre Café & Bistrô. Buscamos um profissional atencioso e organizado para o turno da tarde.",
                qualifications: "- Experiência com operação de caixa e sistemas de PDV\n- Atenção aos detalhes",
                duties: "- Processar pagamentos\n- Realizar a abertura e o fechamento do caixa."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(25, 16),
                title: .cashier,
                durationInHours: 7,
                startDate: date(28, 19),
                salaryBRL: 125,
                description: "JUSSO contrata caixa para o período noturno. Ambiente de bar, necessário agilidade.",
                qualifications: "- Experiência com caixa em bares\n- Simpatia e agilidade",
                duties: "- Receber pagamentos de comandas\n- Controle de fluxo de caixa"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(23, 10),
                title: .cashier,
                durationInHours: 8,
                startDate: date(27, 12),
                salaryBRL: 130,
                description:
                    "Caixa para o El Cactus para o turno do almoço e início da noite. Atendimento ao cliente e fechamento de contas.",
                qualifications: "- Boa comunicação\n- Experiência com sistema Desbravador é um plus",
                duties: "- Operar o caixa\n- Auxiliar no atendimento telefônico"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[5].id,
                postedAt: date(22, 9),
                title: .cashier,
                durationInHours: 6,
                startDate: date(29, 8),
                salaryBRL: 115,
                description:
                    "Caixa para o Doce Amargo Café, turno da manhã. Foco em atendimento rápido para clientes a trabalho.",
                qualifications: "- Agilidade em digitação e recebimento\n- Organização",
                duties: "- Registrar pedidos para viagem\n- Fechamento de contas no balcão"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: date(21, 14),
                title: .cashier,
                durationInHours: 6,
                startDate: date(30, 15),
                salaryBRL: 120,
                description:
                    "Café Sanctus busca operador de caixa com perfil tranquilo e atencioso para o turno da tarde.",
                qualifications: "- Atenção e cuidado com o cliente\n- Postura profissional",
                duties: "- Processar pagamentos com cordialidade\n- Manter a gaveta organizada"
            ),

            // MARK: - Receptionist Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(22, 10),
                title: .receptionist,
                durationInHours: 6,
                startDate: date(28, 18),
                salaryBRL: 140,
                description:
                    "O El Cactus Mexican Grill busca um(a) recepcionista para ser o primeiro contato com nossos clientes.",
                qualifications:
                    "- Excelentes habilidades de comunicação e simpatia.\n- Experiência com sistemas de reserva é um diferencial.",
                duties: "- Gerenciar a porta e as reservas.\n- Acolher e direcionar os clientes às suas mesas."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(25, 9),
                title: .receptionist,
                durationInHours: 7,
                startDate: date(29, 17),
                salaryBRL: 150,
                description:
                    "Recepcionista para o Black Falcon Gastrobar, com foco em gestão de reservas e atendimento telefônico.",
                qualifications: "- Ótima comunicação verbal e escrita\n- Organização",
                duties: "- Atender telefone\n- Gerenciar o mapa de reservas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(24, 11),
                title: .receptionist,
                durationInHours: 8,
                startDate: date(27, 18),
                salaryBRL: 160,
                description:
                    "Red Koi Sushi Bar contrata recepcionista bilíngue para atendimento a clientes nacionais e estrangeiros.",
                qualifications: "- Inglês fluente é obrigatório\n- Experiência em hotelaria ou restaurantes de luxo",
                duties: "- Recepcionar clientes\n- Apresentar o restaurante"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(23, 14),
                title: .receptionist,
                durationInHours: 6,
                startDate: date(28, 19),
                salaryBRL: 135,
                description: "Recepcionista para o El Avante Lounge, para organização da entrada e suporte em eventos.",
                qualifications: "- Proatividade e simpatia\n- Flexibilidade de horário",
                duties: "- Controlar acesso\n- Dar suporte à equipe de eventos"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[8].id,
                postedAt: date(22, 13),
                title: .receptionist,
                durationInHours: 6,
                startDate: date(30, 12),
                salaryBRL: 130,
                description:
                    "Café Sanctus busca recepcionista para o período diurno, com foco em um atendimento calmo e acolhedor.",
                qualifications: "- Cordialidade\n- Postura discreta e profissional",
                duties: "- Receber clientes e turistas\n- Fornecer informações sobre o local"
            ),

            // MARK: - Runner Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(24, 9),
                title: .runner,
                durationInHours: 5,
                startDate: date(30, 19),
                salaryBRL: 95,
                description:
                    "Vaga para Runner no Black Falcon Gastrobar, profissional ágil para garantir que os pratos cheguem da cozinha à mesa com rapidez.",
                qualifications: "- Agilidade e excelente disposição física.\n- Atenção e boa comunicação.",
                duties: "- Transportar os pratos da cozinha para o salão.\n- Auxiliar os garçons."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(25, 20),
                title: .runner,
                durationInHours: 6,
                startDate: date(28, 19),
                salaryBRL: 100,
                description:
                    "Runner (Cumim) para o El Cactus. Suporte essencial para os garçons em um salão grande e movimentado.",
                qualifications: "- Muita agilidade\n- Disposição para longas caminhadas",
                duties: "- Levar pratos e bebidas às mesas\n- Manter as praças de apoio abastecidas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(23, 19),
                title: .runner,
                durationInHours: 7,
                startDate: date(27, 20),
                salaryBRL: 105,
                description:
                    "JUSSO precisa de runner para as noites de final de semana, para levar pedidos do bar e da cozinha.",
                qualifications: "- Foco e velocidade\n- Bom trabalho em equipe",
                duties: "- Entregar pedidos de bebidas e comidas\n- Comunicar-se com bar e cozinha"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(22, 18),
                title: .runner,
                durationInHours: 6,
                startDate: date(29, 19),
                salaryBRL: 110,
                description:
                    "Runner para o Red Koi Sushi Bar. Responsável por levar os pratos delicados da cozinha para o salão com cuidado.",
                qualifications: "- Cuidado no manuseio\n- Agilidade e discrição",
                duties: "- Transportar pratos com segurança\n- Apoiar os garçons no serviço de bebidas"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(21, 20),
                title: .runner,
                durationInHours: 5,
                startDate: date(28, 20),
                salaryBRL: 90,
                description: "El Avante Lounge busca runner para o serviço de petiscos e bebidas no lounge.",
                qualifications: "- Proatividade\n- Boa apresentação",
                duties: "- Levar pedidos às mesas e ao lounge\n- Manter a área de serviço organizada"
            ),

            // MARK: - Sommelier Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(23, 11),
                title: .sommelier,
                durationInHours: 7,
                startDate: date(29, 18),
                salaryBRL: 220,
                description:
                    "Procuramos um Sommelier para o Red Koi Sushi Bar, com foco em harmonização de saquês e vinhos.",
                qualifications:
                    "- Certificação de Sommelier ou experiência comprovada.\n- Profundo conhecimento em vinhos e saquês.",
                duties: "- Desenvolver e gerenciar a carta de bebidas.\n- Recomendar harmonizações aos clientes."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(25, 12),
                title: .sommelier,
                durationInHours: 8,
                startDate: date(28, 18),
                salaryBRL: 250,
                description: "Sommelier para liderar a adega do Black Falcon Gastrobar. Vasta carta de vinhos.",
                qualifications: "- Experiência com gestão de adega\n- Habilidade de treinamento de equipe",
                duties: "- Controle de estoque\n- Serviço de vinhos no salão"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(24, 16),
                title: .sommelier,
                durationInHours: 6,
                startDate: date(27, 19),
                salaryBRL: 200,
                description:
                    "El Avante Lounge contrata Sommelier para o serviço noturno, focado em vinhos do novo e velho mundo.",
                qualifications: "- Certificação WSET 2 ou superior\n- Boa comunicação",
                duties: "- Atendimento e serviço de vinhos\n- Organização da adega do dia"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(22, 14),
                title: .sommelier,
                durationInHours: 5,
                startDate: date(30, 19),
                salaryBRL: 180,
                description:
                    "Sommelier com foco em destilados (Tequila, Mezcal) para o El Cactus. Uma abordagem diferente da sommellerie.",
                qualifications: "- Conhecimento profundo em destilados de agave\n- Criatividade para harmonizações",
                duties: "- Guiar clientes na degustação de tequilas\n- Criar cartas de degustação"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(21, 15),
                title: .sommelier,
                titleOther: "Sommelier de Cervejas",
                durationInHours: 6,
                startDate: date(29, 18),
                salaryBRL: 190,
                description:
                    "JUSSO busca um Sommelier de Cervejas para gerenciar a seleção de artesanais e treinar a equipe.",
                qualifications: "- Certificação de Sommelier de Cervejas\n- Paixão por cerveja artesanal",
                duties: "- Curadoria da carta de cervejas\n- Promover degustações e eventos"
            ),

            // MARK: - Barback Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(22, 18),
                title: .barback,
                durationInHours: 6,
                startDate: date(28, 19),
                salaryBRL: 100,
                description:
                    "O El Avante Lounge precisa de um Auxiliar de Bar (Barback) ágil para dar suporte à equipe de bartenders.",
                qualifications:
                    "- Agilidade, proatividade e organização.\n- Capacidade de trabalhar em um ambiente de ritmo acelerado.",
                duties:
                    "- Manter o estoque de bebidas e insumos do bar abastecido.\n- Realizar a limpeza e organização do balcão."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(25, 18),
                title: .barback,
                durationInHours: 8,
                startDate: date(27, 19),
                salaryBRL: 120,
                description: "Barback para o JUSSO nos finais de semana. Alto volume, trabalho intenso e em equipe.",
                qualifications: "- Força e disposição\n- Experiência prévia é um plus",
                duties: "- Reposição de gelo e bebidas\n- Lavagem de copos e utensílios do bar"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(24, 19),
                title: .barback,
                durationInHours: 7,
                startDate: date(29, 18),
                salaryBRL: 115,
                description:
                    "Auxiliar de bar para o Black Falcon. Suporte na preparação de insumos para coquetéis (mise en place).",
                qualifications: "- Organização e atenção\n- Interesse em coquetelaria",
                duties: "- Preparo de xaropes, sucos e guarnições\n- Manter a estação do bar limpa"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(23, 20),
                title: .barback,
                durationInHours: 6,
                startDate: date(28, 20),
                salaryBRL: 110,
                description:
                    "El Cactus precisa de barback para o bar de margaritas. Foco em reposição de frutas e tequila.",
                qualifications: "- Agilidade e força\n- Disponibilidade noturna",
                duties: "- Repor estoque de frutas, sucos e destilados\n- Manter a limpeza do bar"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[1].id,
                postedAt: date(21, 19),
                title: .barback,
                durationInHours: 6,
                startDate: date(30, 18),
                salaryBRL: 125,
                description:
                    "Red Koi busca um auxiliar de bar cuidadoso para lidar com copos e garrafas de alto valor.",
                qualifications: "- Cuidado e responsabilidade\n- Organização impecável",
                duties: "- Polimento de taças\n- Organização do estoque de bebidas premium"
            ),

            // MARK: - Other Jobs
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(23, 15),
                title: .other,
                titleOther: "Host de Eventos",
                durationInHours: 6,
                startDate: date(29, 17),
                salaryBRL: 180,
                description:
                    "O bar JUSSO contrata um Host de Eventos para organizar e executar noites temáticas, como shows acústicos.",
                qualifications: "- Experiência com produção de pequenos eventos.\n- Proatividade e criatividade.",
                duties:
                    "- Planejar e divulgar o calendário de eventos do bar.\n- Coordenar com artistas e fornecedores."
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[2].id,
                postedAt: date(25, 11),
                title: .other,
                titleOther: "Mariachi",
                durationInHours: 3,
                startDate: date(28, 20),
                salaryBRL: 250,
                description:
                    "Músico ou grupo de Mariachis para apresentação nas noites de sábado no El Cactus Mexican Grill.",
                qualifications: "- Repertório de música mexicana\n- Instrumentos próprios",
                duties: "- Realizar apresentação musical no salão\n- Interagir com os clientes"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[4].id,
                postedAt: date(24, 14),
                title: .other,
                titleOther: "DJ Residente",
                durationInHours: 5,
                startDate: date(27, 21),
                salaryBRL: 300,
                description:
                    "El Avante Lounge busca DJ para as noites de sexta-feira, com foco em lounge, deep house e nu-disco.",
                qualifications: "- Equipamento próprio (controladora)\n- Experiência em lounges e bares",
                duties: "- Criar a atmosfera musical do ambiente\n- Tocar sets conforme a proposta do bar"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[0].id,
                postedAt: date(22, 16),
                title: .other,
                titleOther: "Segurança",
                durationInHours: 8,
                startDate: date(29, 18),
                salaryBRL: 200,
                description:
                    "Vaga para Segurança para o Black Falcon Gastrobar, para controle de acesso e segurança do salão.",
                qualifications: "- Curso de formação de vigilante\n- Postura calma e firme",
                duties: "- Controlar a entrada e saída\n- Garantir a segurança e o bem-estar dos clientes"
            ),
            JobOffer(
                id: UUID(),
                companyId: companies[3].id,
                postedAt: date(21, 13),
                title: .other,
                titleOther: "Promotor de Eventos",
                durationInHours: 4,
                startDate: date(28, 19),
                salaryBRL: 150,
                description: "Promotor de eventos para o JUSSO, para divulgação e recepção em noites especiais.",
                qualifications: "- Boa rede de contatos\n- Simpatia e extroversão",
                duties: "- Divulgar o evento nas redes sociais e em listas\n- Recepcionar convidados"
            ),
        ]
    }

    /// Helper para criar datas de forma mais concisa. Assume o mês e ano atuais (Junho, 2025).
    private func date(_ day: Int, _ hour: Int) -> Date {
        return Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: day, hour: hour))!
    }
}
