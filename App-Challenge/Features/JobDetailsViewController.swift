//
//  JobDetailsViewController.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 10/06/25.
//

import UIKit

class JobDetailsViewController: UIViewController {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
                let scrollView = UIScrollView()
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                return scrollView
        }()
    
    private lazy var jobDetailsTitle: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Detalhes da Vaga"
            label.textAlignment = .center
            label.font = UIFont(name: "SFProRounded-Bold", size: 30)
            return label
        }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição da vaga:"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
            textView.isEditable = false
            textView.isSelectable = false
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.text = """
            Estamos em busca de uma recepcionista para integrar nosso time e garantir uma experiência de excelência aos nossos clientes desde o primeiro contato. Se você tem atenção aos detalhes, postura profissional e paixão pela hospitalidade, esta vaga é para você.
            """
            textView.textColor = .black
            textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0
        textView.tintColor = .systemGray
//        textView.font
        return textView
    }()
    
    lazy var descriptionStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var responsabilitiesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Responsabilidades:"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var responsabilitiesTextView: UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
            textView.isEditable = false
            textView.isSelectable = false
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.text = """
            - Recepcionar os clientes com cordialidade, elegância e discrição.
            - Gerenciar reservas (presenciais, por telefone e plataformas digitais).
            - Organizar a fila de espera e coordenar a ocupação das mesas.
            - Comunicar-se com a equipe de salão e cozinha para garantir fluidez no atendimento.
            - Fornecer informações sobre o restaurante, o menu e o serviço, quando necessário.
            - Resolver imprevistos com empatia e profissionalismo.
            - Manter postura e apresentação impecáveis, alinhadas ao padrão da casa.
            """
            textView.textColor = .black
            textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0
        textView.tintColor = .systemGray2
//        textView.font
        return textView
    }()
    
    lazy var responsabilitiesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [responsabilitiesLabel, responsabilitiesTextView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var requirementsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Requisitos:"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var requirementsTextView: UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
            textView.isEditable = false
            textView.isSelectable = false
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.text = """
            - Experiência em atendimento ou recepção em ambientes sofisticados (restaurantes, hotéis ou eventos).
            - Boa comunicação verbal e escrita.
            - Discrição, proatividade e organização.
            - Fluência em português. Desejável conhecimento em francês e/ou inglês.
            - Familiaridade com sistemas de reservas é um diferencial.
            """
            textView.textColor = .black
            textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 0
        textView.tintColor = .systemGray2
//        textView.font
        return textView
    }()
    
    lazy var requirementsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [requirementsLabel, requirementsTextView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var contactButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registrar interesse na vaga", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(openWhatsApp), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [contactButton, shareButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        view.backgroundColor = .systemGray6
        // Do any additional setup after loading the view.
    }
    
    @objc private func openWhatsApp() {
        print("clicou")
        if let url = URL(string: "https://wa.me/+5551997645781?text=Oi%2C%20vi%20o%20an%C3%BAncio%20da%20vaga%20no%20%2AFreela%20onTap%2A%20e%20gostaria%20de%20me%20candidatar.") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension JobDetailsViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descriptionStack)
        contentView.addSubview(responsabilitiesStack)
        contentView.addSubview(requirementsStack)
        contentView.addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            descriptionStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            descriptionStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            responsabilitiesStack.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 13),
            responsabilitiesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            responsabilitiesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            requirementsStack.topAnchor.constraint(equalTo: responsabilitiesStack.bottomAnchor, constant: 13),
            requirementsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            requirementsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contactButton.widthAnchor.constraint(equalToConstant: 247),
            contactButton.heightAnchor.constraint(equalToConstant: 50),

//            buttonsStack.widthAnchor.constraint(equalToConstant: 200),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            buttonsStack.topAnchor.constraint(equalTo: requirementsStack.bottomAnchor, constant: 30),
            buttonsStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
}
