//
//  CompanyProfile+CKRecord_init.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 19/06/25.
//

import CloudKit

// MARK: - Init CompanyProfile from CloudKit Record
extension CompanyProfile {
    init?(record: CKRecord) {
        guard
            let idString = record["id"] as? String,
            let id = UUID(uuidString: idString),
            let name = record["name"] as? String,
            let establishmentTypeRaw = record["establishmentType"] as? String,
            let establishmentType = EstablishmentType(rawValue: establishmentTypeRaw),
            let cnpj = record["cnpj"] as? String,
            let whatsappNumber = record["whatsappNumber"] as? String,
            let description = record["description"] as? String,
            let companySizeRaw = record["companySize"] as? String,
            let companySize = CompanySize(rawValue: companySizeRaw),
            let streetAndNumber = record["address_streetAndNumber"] as? String,
            let neighborhood = record["address_neighborhood"] as? String,
            let cityAndState = record["address_cityAndState"] as? String
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.establishmentType = establishmentType
        self.cnpj = cnpj
        self.whatsappNumber = whatsappNumber
        self.description = description
        self.companySize = companySize
        self.address = (
            streetAndNumber: streetAndNumber,
            neighborhood: neighborhood,
            cityAndState: cityAndState
        )
    }
}
