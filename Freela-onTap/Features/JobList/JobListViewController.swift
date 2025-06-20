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
    
//    lazy var searchController: UISearchController = {
//        var search = UISearchController.create()
//        search.searchResultsUpdater = self
//        search.searchBar.delegate = self
//        return search
//    }()
    
    lazy var errorEmptyState: ErrorEmptyState = {
        let emptyState = ErrorEmptyState()
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
    }
}

extension JobListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("Degbug: \(searchController.searchBar.text ?? "")")
    }
}

extension JobListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
            backItem.title = "Voltar"
            navigationItem.backBarButtonItem = backItem
        // let selectedJob = indexPath.item
        let vc = JobDetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
