//
//  JobListViewController+ViewCodeProtocol.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit

// MARK: ViewCodeProtocol
extension JobListViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(collectionView)
        
        title = "Descobrir"
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
