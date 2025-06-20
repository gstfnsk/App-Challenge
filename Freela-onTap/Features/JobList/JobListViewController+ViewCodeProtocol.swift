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
        view.addSubview(emptyView)
//        emptyView.isHidden = true
        
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 60),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func adicionalSetup() {
        navigationItem.hidesBackButton = true
    }
}
