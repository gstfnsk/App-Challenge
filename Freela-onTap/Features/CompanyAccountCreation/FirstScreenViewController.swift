//
//  FirstScreenViewController.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 23/06/25.
//

import UIKit
import SwiftUI

class FirstScreenViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.labelsPrimary
        label.text = "Sua equipe começa aqui"
        label.textAlignment = .center
        label.font = UIFont.DesignSystem.title3SemiBold
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cadastre sua empresa e comece a divulgar oportunidades de forma prática e rápida."
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.DesignSystem.subheadline
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    
    // 5 input fields
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.DesignSystem.terracota0
        setup()
    }
    
    @objc func continueAction() {
    }
}

extension FirstScreenViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(titleStack)
        view.addSubview(continueButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        ])
    }
}
#Preview {
    let test = FirstScreenViewController()
    return test
}
