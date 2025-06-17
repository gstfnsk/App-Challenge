//
//  JobListViewController.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit
class JobListViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    // will be populate with CK data
    var jobOffer: [JobOffer] = []

    lazy var searchController: UISearchController = {
        var search = UISearchController.create()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        return search
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
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
        Task {
            do {
                var newJobs = try await CloudKitManager.shared.fetchJobOffers()
                // test
                newJobs.append(JobOffer(id: UUID(), companyId: UUID(), position: JobPosition.bartender, durationTime: 8, startDate: Date(), creationDate: Date(), location: "AVENIDA TAL", salary: 49.00, description: "DESCRICAO", requirements: "teste", responsibilities: "top"))
                
                if areJobsDifferent(oldJobs: jobOffer, newJobs: newJobs) {
                    jobOffer = newJobs
                    print("There are new data.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        print("There is not new data.")
                    }
                }
            } catch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    print("Erro ao buscar vagas: \(error)")
                }
            }
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
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
