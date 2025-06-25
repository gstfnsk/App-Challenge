//
//  JobListViewController.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit

class JobListViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    var listedJobOffers: [JobOffer] = []

    internal var numberOfSections = 3
    internal var filterSectionId = 0
    internal var titleSectionId = 1
    internal var jobListingSectionId = 2

    //    lazy var searchController: UISearchController = {
    //        var search = UISearchController.create()
    //        search.searchResultsUpdater = self
    //        search.searchBar.delegate = self
    //        return search
    //    }()
    
    lazy var emptyView: EmptyStateJobBoard = {
        let emptyView = EmptyStateJobBoard()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()
    
    lazy var errorEmptyState: ErrorEmptyStateJobBoard = {
        let emptyState = ErrorEmptyStateJobBoard()
        emptyState.translatesAutoresizingMaskIntoConstraints = false
        return emptyState
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: UIColor.DesignSystem.terracota600
        ]
        
        let attributedTitle = NSAttributedString(string: "Recarregar", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonRefresh), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonRefresh() {
        print("clicou")
        self.updateJobOfferList()
        self.collectionView.reloadData()
    }

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BadgeLabelViewCell.self, forCellWithReuseIdentifier: BadgeLabelViewCell.identifier)
        collectionView.register(TitleJobListCell.self, forCellWithReuseIdentifier: TitleJobListCell.identifier)
        collectionView.register(JobListCell.self, forCellWithReuseIdentifier: JobListCell.identifier)
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        refreshControl.addTarget(self, action: #selector(refreshJobs), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    //
    func areJobsDifferent(oldJobs: [JobOffer], newJobs: [JobOffer]) -> Bool {
        let oldIDs = Set(oldJobs.map(\.id))
        let newIDs = Set(newJobs.map(\.id))
        return oldIDs != newIDs
    }

    @objc private func refreshJobs() {
        // swiftlint:disable:next trailing_closure
        updateJobOfferList(finally: {
            self.refreshControl.endRefreshing()
        })
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        updateJobOfferList()
//        addMockDataTrigger()
        
        collectionView.backgroundColor = .DesignSystem.lavanda0
    }
}

extension JobListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("Degbug: \(searchController.searchBar.text ?? "")")
    }
}

extension JobListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section

        if section == filterSectionId {
            if indexPath.item == 0 {
                SelectedPositions.clearAll()
            } else {
                let jobPosition = JobPosition.allCases[indexPath.item - 1]
                if SelectedPositions.getSelectedPositions().contains(jobPosition) {
                    SelectedPositions.remove(position: jobPosition)
                } else {
                    SelectedPositions.add(position: jobPosition)
                }
            }
            updateJobOfferList()
            collectionView.reloadData()
        } else if indexPath.section == jobListingSectionId {
            let backItem = UIBarButtonItem()
            backItem.title = "Voltar"
            navigationItem.backBarButtonItem = backItem
            let jobDetailsVC = JobDetailsViewController()
            let selectedJobOffer = listedJobOffers[indexPath.row]
            jobDetailsVC.configure(with: selectedJobOffer)

            navigationController?.pushViewController(jobDetailsVC, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let section = indexPath.section

        if section == 0 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BadgeLabelViewCell else {
                return
            }
            SelectedPositions.remove(position: cell.cellJob())
            updateJobOfferList()
            collectionView.reloadData()
        }
    }

    private func addMockDataTrigger(){
        let mockButton = MockdataHoldButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    mockButton.parentViewController = self
    mockButton.onConfirmRestore = {
        Task {
            do {
                try await CloudKitManager.shared.deleteAllMockData()
                try await CloudKitManager.shared.addMockCompaniesAndJobs()

                await MainActor.run {
                    self.updateJobOfferList()
                    self.collectionView.reloadData()

                    let alert = UIAlertController(
                        title: "Mock Data Restored",
                        message: "The mock job offers were restored.\n\nIt may take a few minutes for CloudKit to propagate the changes.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                await MainActor.run {
                    let errorAlert = UIAlertController(
                        title: "Error",
                        message: "Failed to restore mock data: \(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }

    let barButtonItem = UIBarButtonItem(customView: mockButton)
    navigationItem.rightBarButtonItem = barButtonItem
    }
}
