//
//  Onboarding2+ViewCodeProtocol.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 18/06/25.
//
import UIKit

extension Onboarding2ViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(onboardingCollectionView)
        view.addSubview(swipeButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            swipeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            swipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            swipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            swipeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
