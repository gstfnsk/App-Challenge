//
//  JobListViewController.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit
class JobListViewController: UIViewController {
    var listedJobOffers: [JobOffer] = []
    
    lazy var searchController: UISearchController = {
        var search = UISearchController.create()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        return search
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
        return collectionView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
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
        // let selectedJob = indexPath.item
        let vc = JobDetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
