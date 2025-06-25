//
//  CompanyPublishedJobsViewController+UICollectionViewDataSource.swift
//  App-Challenge
//

import UIKit

// MARK: CollectionView DataSource

extension CompanyPublishedJobsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == filterSectionId {
            return JobPosition.allCases.count + 1
        }

        if isHeaderSection(section) {
            return 1
        }

        if isJobListSection(section) {
            switch section {
            case openJobsListSectionId:
                return openJobs.count
            case filledJobsListSectionId:
                return filledJobs.count
            case closedJobsListSectionId:
                return closedJobs.count
            default:
                // Fallback
                return 0
            }
        }

        // Fallback
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let section = indexPath.section

        // MARK: Filter section
        if section == filterSectionId {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BadgeLabelViewCell.identifier,
                    for: indexPath
                ) as? BadgeLabelViewCell
            else {
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

        // Header section
        if isHeaderSection(section) {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CompanyPublishedJobsHeader.identifier,
                    for: indexPath
                )
                    as? CompanyPublishedJobsHeader
            else {
                fatalError("Erro ao criar CompanyPublishedJobsHeader")
            }

            switch section {
            case openJobsTitleSectionId:
                cell.text = "Abertas"
            case filledJobsTitleSectionId:
                cell.text = "Preenchidas"
            case closedJobsTitleSectionId:
                cell.text = "Encerradas"
            default:
                break
            }
            return cell
        }

        if isJobListSection(section) {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: JobOfferCollectionViewCell.identifier,
                    for: indexPath
                )
                    as? JobOfferCollectionViewCell
            else {
                fatalError("Erro ao criar CardCollectionViewCell")
            }

            switch section {
            case openJobsListSectionId:
                cell.state = .open
            case filledJobsListSectionId:
                cell.state = .filled
            case closedJobsListSectionId:
                cell.state = .disabled
            default:
                break
            }

            return cell
        }

        // If none of the sectios were matched, return an empty cell
        return UICollectionViewCell()
    }
}

extension CompanyPublishedJobsViewController {
    func updateJobOfferList(
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (_ error: Error) -> Void = { _ in },
        finally: @escaping () -> Void = {}
    ) {
        Task {
            do {
                collectionView.isHidden = false
                navigationController?.setNavigationBarHidden(false, animated: true)

                var jobOffers = try await CloudKitManager.shared.fetchAllJobOffers()
                jobOffers = SelectedPositions.applyFilter(to: jobOffers)
                jobOffers.sort { $0.postedAt > $1.postedAt }

                await MainActor.run {
                    // TODO: Apply the correct filters
                    self.openJobs = Array(jobOffers.prefix(3))
                    self.filledJobs = Array(jobOffers.dropFirst(3).prefix(2))
                    self.closedJobs = Array(jobOffers.dropFirst(5).prefix(2))

                    self.collectionView.reloadData()

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
                    navigationController?.setNavigationBarHidden(true, animated: true)

                    onFailure(error)
                    finally()
                }
            }
        }
    }
}
