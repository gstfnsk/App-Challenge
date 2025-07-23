//
//  JobOffer+CKRecord_init.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 19/06/25.
//

import CloudKit

// MARK: - Init JobOffer from CloudKit Record
extension JobOffer {
    init?(record: CKRecord) {
        guard
            let idString = record["id"] as? String,
            let id = UUID(uuidString: idString),

            let companyIdString = record["companyId"] as? String,
            let companyId = UUID(uuidString: companyIdString),

            let postedAt = record["postedAt"] as? Date,

            let titleString = record["title"] as? String,
            let title = JobPosition.fromCaseName(titleString),

            let durationInHours = record["durationInHours"] as? Int,
            let startDate = record["startDate"] as? Date,

            let salaryNumber = record["salaryBRL"] as? NSNumber,

            let description = record["description"] as? String,
            let qualifications = record["qualifications"] as? String,
            let duties = record["duties"] as? String
        else {
            return nil
        }

        self.id = id
        self.companyId = companyId
        self.postedAt = postedAt
        self.title = title
        self.titleOther = record["titleOther"] as? String
        self.durationInHours = durationInHours
        self.startDate = startDate
        self.salaryBRL = salaryNumber.intValue
        self.description = description
        self.qualifications = qualifications
        self.duties = duties
    }
}
