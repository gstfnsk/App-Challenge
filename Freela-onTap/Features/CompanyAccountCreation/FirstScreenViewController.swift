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
        label.numberOfLines = 0
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
    
    lazy var inputsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [name, cnpj, companySize, typeOfCompany, whatsapp])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy var name: TextInput = {
       let input = TextInput()
        input.labelText = "Nome fantasia:"
        input.placeholderText = "Sunset Drinks"
        return input
    }()
    
    lazy var cnpj: TextInput = {
       let input = TextInput()
        input.labelText = "CNPJ:"
        input.placeholderText = "12.345.678.0001-23"
        return input
    }()
    
    lazy var companySize: TextInput = {
       let input = TextInput()
        input.labelText = "Tamanho da empresa:"
        input.placeholderText = "Selecionar"
        return input
    }()
    
    lazy var typeOfCompany: TextInput = {
       let input = TextInput()
        input.labelText = "Tipo de estabelecimento:"
        input.placeholderText = "Selecionar"
        return input
    }()
    
    lazy var whatsapp: TextInput = {
       let input = TextInput()
        input.labelText = "Whatsapp:"
        input.placeholderText = "+55 51 98765-4321"
        return input
    }()
    
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Cadastro de conta"
        
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
        view.addSubview(inputsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 149),
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            
            inputsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 237),
            inputsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
#Preview {
    let test = FirstScreenViewController()
    return test
}
