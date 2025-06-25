//
//  SecondScreenViewController.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 25/06/25.
//

import UIKit
import SwiftUI

class SecondScreenViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.labelsPrimary
        label.text = "Onde fica seu negócio?"
        label.textAlignment = .center
        label.font = UIFont.DesignSystem.title3SemiBold
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Informe seu endereço para que freelancers vejam onde será o trabalho."
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.DesignSystem.subheadline
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
        var stack = UIStackView(arrangedSubviews: [cep, street, streetNumber, complement, neighborhood, city, state])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var cep: TextInput = {
       let input = TextInput()
        input.labelText = "CEP:"
        input.placeholderText = "98765-432"
        return input
    }()
    
    private lazy var street: TextInput = {
       let input = TextInput()
        input.labelText = "Rua / Logradouro:"
        input.placeholderText = "R. Osvaldo Aranha"
        return input
    }()
    
    private lazy var streetNumber: TextInput = {
       let input = TextInput()
        input.labelText = "Número:"
        input.placeholderText = "1088"
        return input
    }()
    
    private lazy var complement: TextInput = {
       let input = TextInput()
        input.labelText = "Complemento:"
        input.placeholderText = "Loja 107"
        return input
    }()
    
    private lazy var neighborhood: TextInput = {
       let input = TextInput()
        input.labelText = "Bairro:"
        input.placeholderText = "Petrópolis"
        return input
    }()
    
    private lazy var city: TextInput = {
       let input = TextInput()
        input.labelText = "Cidade:"
        input.placeholderText = "Porto Alegre"
        return input
    }()
    
    private lazy var state: TextInput = {
       let input = TextInput()
        input.labelText = "Estado:"
        input.placeholderText = "Rio Grande do Sul"
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
        label.text = "Etapa 2 de 3"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.labelsPrimary
        label.font = UIFont.DesignSystem.caption2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Cadastro de conta"
        
        view.backgroundColor = UIColor.DesignSystem.lavanda0
        
        progressBar.currentState = .second

        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    @objc func continueAction() {
    }
}

extension SecondScreenViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(progressBar)
        scrollView.addSubview(label)
        scrollView.addSubview(titleStack)
        scrollView.addSubview(continueButton)
        scrollView.addSubview(inputsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 149),
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    
            inputsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 237),
            inputsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.topAnchor.constraint(equalTo: inputsStack.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        ])
    }
}
#Preview {
    let test = SecondScreenViewController()
    return test
}
