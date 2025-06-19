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


// MARK: - Get Enum Case Name (String)
extension RawRepresentable where Self: CaseIterable {
    var caseName: String {
        String(describing: self)
    }
}

// MARK: - Create Enum Case from Case Name String
extension CaseIterable where Self: RawRepresentable {
    static func fromCaseName(_ caseName: String) -> Self? {
        allCases.first { String(describing: $0) == caseName }
    }
}

// MARK: - timeAgoString
extension Date {
    func timeAgoString() -> String {
        let now = Date()
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.unitsStyle = .abbreviated
                
        return  formatter.localizedString(for: self, relativeTo: now)
    }
}
