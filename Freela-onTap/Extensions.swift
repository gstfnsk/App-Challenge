//
//  Extensions.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.
//

import UIKit

typealias Size = NSCollectionLayoutSize
typealias Item = NSCollectionLayoutItem
typealias Group = NSCollectionLayoutGroup
typealias Section = NSCollectionLayoutSection
typealias Layout = UICollectionViewCompositionalLayout
typealias Edges = NSDirectionalEdgeInsets
typealias Config = UICollectionViewCompositionalLayoutConfiguration

extension UISearchController {
    static func create(localizedPlaceholder placeholder: String = "Search") -> UISearchController {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        return searchController
    }
}
