//
//  JobListViewController+CollectionViewLayout.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit
// MARK: CollectionView Layout
extension JobListViewController {
    func createSection0() -> Section {
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
    
    func createSection1() -> Section {
        /// item
        let itemSize = Size(widthDimension: .absolute(390.0), heightDimension: .absolute(53.0))
        let item = Item(layoutSize: itemSize)
        
        /// group
        let groupSize = Size(widthDimension: .estimated(393.0), heightDimension: .absolute(34.0))
        let group = Group.horizontal(layoutSize: groupSize, subitems: [item])
                
        /// section
        let section = Section(group: group)
        section.contentInsets = Edges(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return section
    }
    
    func createSection2() -> Section {
        // item
        let itemSize = Size(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(174)
        )
        let item = Item(layoutSize: itemSize)
        // group
        let groupSize = Size(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(174)
        )
        let group = Group.vertical(layoutSize: groupSize, subitems: [item])
        // section
        let section = Section(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = Edges(top: 20, leading: 16, bottom: 16, trailing: 16)
        return section
    }
    
    func createAllLayout() -> UICollectionViewLayout {
        return Layout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.createSection0()
            case 1:
                return self.createSection1()
            default:
                return self.createSection2()
            }
        }
    }
}
