//
//  CompanyPublishedJobsViewController.swift
//  App-Challenge
//

import UIKit

class CompanyPublishedJobsViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    
    var openJobs: [JobOffer] = []
    var filledJobs: [JobOffer] = []
    var closedJobs: [JobOffer] = []

    internal var numberOfSections = 7
    internal var filterSectionId = 0
    internal var openJobsTitleSectionId = 1
    internal var openJobsListSectionId: Int {openJobsTitleSectionId + 1}
    internal var filledJobsTitleSectionId = 3
    internal var filledJobsListSectionId: Int {filledJobsTitleSectionId + 1}
    internal var closedJobsTitleSectionId = 5
    internal var closedJobsListSectionId: Int {closedJobsTitleSectionId + 1}

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(BadgeLabelViewCell.self, forCellWithReuseIdentifier: BadgeLabelViewCell.identifier)
        collectionView.register(CompanyPublishedJobsHeader.self, forCellWithReuseIdentifier: CompanyPublishedJobsHeader.identifier)
        collectionView.register(JobOfferCollectionViewCell.self, forCellWithReuseIdentifier: JobOfferCollectionViewCell.identifier)
       
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.allowsMultipleSelection = true
        
        refreshControl.addTarget(self, action: #selector(refreshJobs), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        updateJobOfferList()
        
        collectionView.backgroundColor = .DesignSystem.lavanda0
    }
    
    @objc private func refreshJobs() {
        // swiftlint:disable:next trailing_closure
        updateJobOfferList(finally: {
            self.refreshControl.endRefreshing()
        })
    }
}

extension CompanyPublishedJobsViewController: UICollectionViewDelegate {
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
        }
        
        // Is JobList section
        else if isJobListSection(section) {
            let backItem = UIBarButtonItem()
            backItem.title = "Voltar"
            navigationItem.backBarButtonItem = backItem
            
            let jobDetailsVC = JobDetailsViewController()
            
            let selectedJobOffer: JobOffer = {
                switch section {
                case openJobsListSectionId:
                    return openJobs[indexPath.item]
                case filledJobsListSectionId:
                    return filledJobs[indexPath.item]
                default: // closedJobsListSectionId
                    return closedJobs[indexPath.item]
                }
            }()
            
            jobDetailsVC.configure(with: selectedJobOffer)

            navigationController?.pushViewController(jobDetailsVC, animated: true)
        }
        
        // Is JobList title section
        else if isHeaderSection(section) {
            // No action
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let section = indexPath.section

        if section == filterSectionId {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BadgeLabelViewCell else {
                return
            }
            SelectedPositions.remove(position: cell.cellJob())
            updateJobOfferList()
            collectionView.reloadData()
        }
    }
}
