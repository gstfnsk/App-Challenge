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
    
    lazy var emptyView: EmptyState = {
        let emptyView = EmptyState()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()

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

        collectionView.backgroundColor = .DesignSystem.lavanda0

        setup()
        updateJobOfferList()
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 0)
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            self.updateJobOfferList()
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
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
}
