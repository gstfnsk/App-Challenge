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
        numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == filterSectionId {
            return JobPosition.allCases.count + 1
        }
        if section == titleSectionId {
            return 1
        }
        if section == jobListingSectionId {
            if listedJobOffers.isEmpty && !errorEmptyState.isHidden {
                emptyView.isHidden = false
            } else {
                emptyView.isHidden = true
            }
            return listedJobOffers.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if section == filterSectionId {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BadgeLabelViewCell.identifier,
                for: indexPath
            ) as? BadgeLabelViewCell else {
                fatalError("Erro ao criar BadgeCollectionViewCell")
            }
            
            let selectedJobPositions: Set<JobPosition> = SelectedPositions.getSelectedPositions()
            
            if indexPath.item == 0 {
                cell.configure(title: "Todos", imageName: "checklist.checked")
                if selectedJobPositions.isEmpty {
                    cell.setSelectedStyle()
                } else {
                    cell.setDeselectedStyle()
                }
            } else {
                let jobPosition = JobPosition.allCases[indexPath.item - 1]
                cell.configure(title: jobPosition.rawValue.capitalized, imageName: jobPosition.iconName)
                
                
                if selectedJobPositions.contains(jobPosition) {
                    cell.setSelectedStyle()
                } else {
                    cell.setDeselectedStyle()
                }
            }
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

    private func jobCellForItem(at indexPath: IndexPath) -> JobOfferCollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobOfferCollectionViewCell.identifier, for: indexPath)
                as? JobOfferCollectionViewCell
        else {
            fatalError("Erro ao criar CardCollectionViewCell")
        }

        cell.configure(job: listedJobOffers[indexPath.item])
        return cell
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
        collectionView.isHidden = true
    }

    func hideEmptyView() {
        emptyView.isHidden = true
        collectionView.isHidden = false
    }
}

extension JobListViewController {
    func updateJobOfferList(
        forceUpdate: Bool = false,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (_ error: Error) -> Void = { _ in },
        finally: @escaping () -> Void = {}
    ) {
        Task {
            do {
                collectionView.isHidden = false
                refreshButton.isHidden = true
                errorEmptyState.isHidden = true
                navigationController?.setNavigationBarHidden(false, animated: true)
                var jobOffers = try await CloudKitManager.shared.fetchAllJobOffers(forceUpdate: forceUpdate)
                jobOffers = SelectedPositions.applyFilter(to: jobOffers)
                jobOffers.sort { $0.postedAt > $1.postedAt }
                
                await MainActor.run {
                    self.listedJobOffers = jobOffers
                    self.collectionView.reloadData()
                    
//                    if jobOffers.isEmpty {
//                        self.showEmptyView()
//                    } else {
//                        self.hideEmptyView()
//                    }
                    
                    onSuccess()
                    finally()
                }
            } catch {
                await MainActor.run {
                    let alert = UIAlertController(
                            title: "Error",
                            message: "Could not fetch job offers." + error.localizedDescription,
                            preferredStyle: .alert
                        )
                        
                        if let error = error as? CloudKitError {
                            alert.message = error.localizedDescription
                        }
                       
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    
                    // emptystate
                    collectionView.isHidden = true
                    refreshButton.isHidden = false
                    errorEmptyState.isHidden = false
                    navigationController?.setNavigationBarHidden(true, animated: true)
                        
                    onFailure(error)
                    finally()
                }
            }
        }
    }
}
