//
//  JobListViewController+UICollectionViewDataSource.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//

import UIKit

// MARK: CollectionView DataSource
extension JobListViewController: UICollectionViewDataSource {
    private var numberOfSections: Int { 3 }
    private var filterSectonId: Int { 0 }
    private var titleSectionId: Int { 1 }
    private var jobListingSectionId: Int { 2 }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == filterSectonId {
            return JobPosition.allCases.count
        }
        if section == titleSectionId {
            return 1
        }
        if section == jobListingSectionId {
            return listedJobOffers.count
        }

        // If none of the sectios were matched, return 0
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let section = indexPath.section
        if section == filterSectonId {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: BadgeLabelViewCell.identifier, for: indexPath) as? BadgeLabelViewCell else {
                fatalError("Erro ao criar CardCollectionViewCell")
            }
            let jobPostion = JobPosition.allCases[indexPath.item]
            cell.configure(title: jobPostion.rawValue.capitalized, imageName: jobPostion.iconName)
            return cell
        }

        // Page title
        if section == titleSectionId {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TitleJobListCell.identifier,
                    for: indexPath
                ) as? TitleJobListCell
            else {
                fatalError("Erro ao criar TitleJobListCell (section 1)")
            }
            return cell
        }

        if section == jobListingSectionId {
            return jobCellForItem(at: indexPath)
        }

        // If none of the sectios were matched, return an empty cell
        return UICollectionViewCell()
    }

    private func jobCellForItem(at indexPath: IndexPath) -> JobListCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobListCell.identifier, for: indexPath)
                as? JobListCell
        else {
            fatalError("Erro ao criar CardCollectionViewCell")
        }

        cell.configure(job: listedJobOffers[indexPath.item])
        return cell
    }
}

extension JobListViewController {
    func updateJobOfferList(afterCompletion completion: @escaping () -> Void = {}) {
        CloudKitManager.databaseQueue.async {
            Task {
                do {
                    let jobOffers = try await CloudKitManager.shared.fetchJobOffers()

                    DispatchQueue.main.async {
                        completion()
                        self.listedJobOffers = jobOffers
                        self.collectionView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion()
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Could not fetch job offers.",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
}
