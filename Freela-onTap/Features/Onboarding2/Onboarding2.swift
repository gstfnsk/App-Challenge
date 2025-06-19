//
//  Onboarding2.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 18/06/25.
//

import UIKit

class Onboarding2: UIViewController {
    var currentIndex = 0
    
    lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(Onboarding2Cell.self, forCellWithReuseIdentifier: Onboarding2Cell.identifier)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var swipeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 205 / 255, green: 83 / 255, blue: 39 / 255, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Próximo", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonAction() {
        if currentIndex == 0 {
            currentIndex += 1
            let indexPath = IndexPath(item: currentIndex, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            swipeButton.setTitle("Começar Agora", for: .normal)
        }
//        } else {
//            //navegação
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        view.backgroundColor = .blue
    }
}
