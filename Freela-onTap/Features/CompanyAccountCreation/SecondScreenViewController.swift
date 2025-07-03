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
        label.applyDynamicFont(UIFont.DesignSystem.title3SemiBold)
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Informe seu endereço para que freelancers vejam onde será o trabalho."
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
        
        input.editingFunc = { [weak self, weak input] in
            guard let cep = input?.text?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression),
                  cep.count == 8 else {
                return
            }
            self?.fetchAdress(cep: cep)
        }
        
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
    
    private lazy var labelView: UIView = {
        let labelView = UIView()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = UIColor.DesignSystem.lavanda0
        return labelView
    }()
    
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
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(tapDismissKeyboard)
        setup()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func continueAction() {
        let thirdScreen = ThirdScreenViewController()
        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(thirdScreen, animated: true)
    }
    
    @objc func cepDidChange() {
        guard let cep = cep.text?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression),
              cep.count == 8 else {
            return
        }
        fetchAdress(cep: cep)
    }
    
    private func fetchAdress(cep: String) {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json/") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                return
            }
            
            do {
                let endereco = try JSONDecoder().decode(Endereco.self, from: data)
                DispatchQueue.main.async {
                    self.street.text = endereco.logradouro
                    self.neighborhood.text = endereco.bairro
                    self.city.text = endereco.localidade
                    self.state.text = endereco.uf
                }
            } catch {
                print("Erro ao decodificar JSON:", error)
            }
        }
        
        task.resume()
    }
}

extension SecondScreenViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleStack)
        contentView.addSubview(continueButton)
        contentView.addSubview(inputsStack)
        contentView.addSubview(labelView)
        labelView.addSubview(label)
        scrollView.addSubview(progressBar)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelView.heightAnchor.constraint(equalToConstant: 41),
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 51),
            titleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    
            inputsStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 20),
            inputsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            inputsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.topAnchor.constraint(equalTo: inputsStack.bottomAnchor, constant: 50),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
#Preview {
    let test = SecondScreenViewController()
    return test
}

struct Endereco: Decodable {
    let logradouro: String
    let bairro: String
    let localidade: String
    let uf: String
}
