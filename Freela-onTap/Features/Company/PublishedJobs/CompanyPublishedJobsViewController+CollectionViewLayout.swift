//
//  CompanyPublishedJobsViewController+CollectionViewLayout.swift
//  App-Challenge
//

import UIKit

// MARK: CollectionView Layout
extension CompanyPublishedJobsViewController {
    func createFilterSectionLayout() -> Section {
        /// item
        let itemSize = Size(widthDimension: .estimated(93), heightDimension: .absolute(28))
        let item = Item(layoutSize: itemSize)

        /// group
        let groupSize = Size(widthDimension: .estimated(64.0), heightDimension: .absolute(34.0))
        let group = Group.horizontal(layoutSize: groupSize, subitems: [item])

        /// section
        let section = Section(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = Edges(top: 16.0, leading: 16.0, bottom: 0, trailing: 16.0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }

    func createHeaderSectionLayout() -> Section {
        /// item
        let itemSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = Item(layoutSize: itemSize)

        /// group
        let groupSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60.0))
        let group = Group.horizontal(layoutSize: groupSize, subitems: [item])

        /// section
        let section = Section(group: group)
        section.contentInsets = Edges(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    func createJobListSectionLayout() -> Section {
        // item
        let itemSize = Size(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = Item(layoutSize: itemSize)
        
        // group
        let groupSize = Size(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(140.0)
        )
        let group = Group.vertical(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = Section(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = Edges(top: 20, leading: 16, bottom: 16, trailing: 16)
        return section
    }

    var collectionLayout: UICollectionViewLayout {
        return Layout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                return self.createFilterSectionLayout()
            }
            
            if self.isHeaderSection(sectionIndex) {
                return self.createHeaderSectionLayout()
            }
            
            if self.isJobListSection(sectionIndex) {
                return self.createJobListSectionLayout()
            }
            // Fallback
            return NSCollectionLayoutSection(
                group: .init(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(100)))
            )
        }
    }

    func isJobListSection(_ section: Int) -> Bool {
        return section.isMultiple(of: 2) && section < numberOfSections && section != 0
    }

    func isHeaderSection(_ section: Int) -> Bool {
        return !section.isMultiple(of: 2) && section < numberOfSections && section != 0
    }
}
