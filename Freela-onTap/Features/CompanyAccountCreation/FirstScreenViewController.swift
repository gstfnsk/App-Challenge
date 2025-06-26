//
//  FirstScreenViewController.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 23/06/25.
//

import UIKit
import SwiftUI

class FirstScreenViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.labelsPrimary
        label.text = "Sua equipe começa aqui"
        label.textAlignment = .center
        label.applyDynamicFont(UIFont.DesignSystem.title3SemiBold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Cadastre sua empresa e comece a divulgar oportunidades de forma prática e rápida."
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.applyDynamicFont(UIFont.DesignSystem.subheadline)
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    
    private lazy var inputsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [name, cnpj, companyStack, typeOfCompanyStack, whatsapp])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var name: TextInput = {
       let input = TextInput()
        input.labelText = "Nome fantasia:"
        input.placeholderText = "Sunset Drinks"
        return input
    }()
    
    private lazy var cnpj: TextInput = {
       let input = TextInput()
        input.labelText = "CNPJ:"
        input.placeholderText = "12.345.678.0001-23"
        return input
    }()
    
    private lazy var companySizeLabel: UILabel = {
        let companySizeLabel = UILabel()
        companySizeLabel.translatesAutoresizingMaskIntoConstraints = false
        companySizeLabel.font = UIFont.DesignSystem.subheadline
        companySizeLabel.text = "Tamanho da empresa"
        companySizeLabel.textColor = UIColor.labelsSecondary
        return companySizeLabel
    }()
    
    lazy var companyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [companySizeLabel, companySize])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var typeOfCompanyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [typeOfCompanyLabel, typeOfCompany])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var typeOfCompanyLabel: UILabel = {
        let typeOfCompanyLabel = UILabel()
        typeOfCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        typeOfCompanyLabel.text = "Tamanho da empresa"
        typeOfCompanyLabel.font = UIFont.DesignSystem.subheadline
        typeOfCompanyLabel.textColor = UIColor.labelsSecondary
        return typeOfCompanyLabel
    }()
    
    private lazy var companySize: SizeSelector = {
        let companySize = SizeSelector()
        return companySize
    }()
    
    private lazy var typeOfCompany: TypeOfRestaurantSelector = {
        let typeOfCompany = TypeOfRestaurantSelector()
        return typeOfCompany
    }()
    
    
    private lazy var whatsapp: TextInput = {
       let input = TextInput()
        input.labelText = "Whatsapp:"
        input.placeholderText = "+55 51 98765-4321"
        return input
    }()
    
    
    private lazy var continueButton: UIButton = {
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
    
    private lazy var progressBar = ProgressBar()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Etapa 1 de 3"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.labelsPrimary
        label.font = UIFont.DesignSystem.caption2
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Cadastro de conta"
        
        view.backgroundColor = .DesignSystem.lavanda0
        
        progressBar.currentState = .first

        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    @objc func continueAction() {
        let secondScreen = SecondScreenViewController()
        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(secondScreen, animated: true)
    }
}

extension FirstScreenViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(label)
        view.addSubview(titleStack)
        view.addSubview(continueButton)
        view.addSubview(inputsStack)
        view.addSubview(progressBar)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
            
            label.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 149),
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            
            inputsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 237),
            inputsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
//        guard let nav = self.navigationController else {
//            return
//        }
//        
//        progressBar.topAnchor.constraint(equalTo: nav.navigationBar.bottomAnchor).isActive = true
    }
}
#Preview {
    let test = FirstScreenViewController()
    return test
}
