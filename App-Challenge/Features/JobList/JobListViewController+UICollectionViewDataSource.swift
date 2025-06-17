//
//  JobListViewController+UICollectionViewDataSource.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit
// MARK: CollectionView DataSource
extension JobListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let jobPositions = JobPosition.allCases
        if section == 0 {
            return jobPositions.count
        }
        if section == 1 {
            return 1
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let jobPositions = JobPosition.allCases
        if section == 0 {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: BadgeLabelViewCell.identifier, for: indexPath) as? BadgeLabelViewCell else {
                fatalError("Erro ao criar CardCollectionViewCell")
            }
            let job = jobPositions[indexPath.item]
            cell.configure(title: job.rawValue.capitalized, imageName: job.iconName)
            return cell
        }
        if section == 1 {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: TitleJobListCell.identifier, for: indexPath) as? TitleJobListCell else {
                fatalError("Erro ao criar TitleJobListCell (section 1)")
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: JobListCell.identifier, for: indexPath) as? JobListCell else {
            fatalError("Erro ao criar CardCollectionViewCell")
        }
        
        let job1 = JobOffer(id: UUID(), companyId: UUID(), position: .barback, durationTime: 5, startDate: Date(), creationDate: .now, location: "São Paulo", salary: 1000, description: "Lorem ipsum dolor sit amet", requirements: "requirements", responsibilities: "resposibilities")
        cell.configure(job: job1)
        return cell
    }
}
