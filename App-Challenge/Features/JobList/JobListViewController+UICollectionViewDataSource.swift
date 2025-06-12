//
//  JobListViewController+UICollectionViewDataSource.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit

// MARK: CollectionView DataSource
extension JobListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 15
        }
        if section == 1 {
            return 1
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell
        else { fatalError("Error na celula") }
        
        cell.configure(title: "teste", bgColor: .blue)
                
        return cell
    }
}
