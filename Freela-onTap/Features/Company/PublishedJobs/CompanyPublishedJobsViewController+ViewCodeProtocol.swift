//
//  CompanyPublishedJobsViewController+ViewCodeProtocol.swift
//  App-Challenge
//
//

import UIKit

// MARK: ViewCodeProtocol
extension CompanyPublishedJobsViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(collectionView)
      
        title = "Minhas vagas"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    
    func adicionalSetup() {
        navigationItem.hidesBackButton = true
    }
}
