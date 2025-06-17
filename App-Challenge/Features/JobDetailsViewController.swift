//
//  JobDetailsViewController.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 10/06/25.
//

import UIKit

class JobDetailsViewController: UIViewController {
    private var jobOffer: JobOffer?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 361, height: 196)
        let image0 = UIImage(named: "DefaultRestaurantPhoto")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.23, tx: 0, ty: -0.11))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        view.layer.cornerRadius = 4
        var parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 275).isActive = true
        view.heightAnchor.constraint(equalToConstant: 183).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 1).isActive = true
        return view
    }()

    
    private lazy var scrollView: UIScrollView = {
                let scrollView = UIScrollView()
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                return scrollView
        }()
    
//    private lazy var placeholderLabel: UILabel = {
//        var label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "[placeholder]"
//        label.textAlignment = .center
//        return label
//    }()
    
    private lazy var companyNameTitle: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Le Cochon Volant"
            label.font = UIFont(name: "SFProRounded-Bold", size: 30)
            return label
        }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição da vaga:"
        return label
    }()
    
        private lazy var descriptionText: UILabel = {
            var label = UILabel()
            label.numberOfLines = 0
            label.text = """
                Estamos em busca de uma recepcionista para integrar nosso time e garantir uma experiência de excelência aos nossos clientes desde o primeiro contato. Se você tem atenção aos detalhes, postura profissional e paixão pela hospitalidade, esta vaga é para você.
                """
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12)
            return label
        }()
    
    private lazy var descriptionStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var responsibilitiesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Responsabilidades:"
        return label
    }()
    
    private lazy var responsibilitiesText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = """
                    - Recepcionar os clientes com cordialidade, elegância e discrição.
                    - Gerenciar reservas (presenciais, por telefone e plataformas digitais).
                    - Organizar a fila de espera e coordenar a ocupação das mesas.
                    - Comunicar-se com a equipe de salão e cozinha para garantir fluidez no atendimento.
                    - Fornecer informações sobre o restaurante, o menu e o serviço, quando necessário.
                    - Resolver imprevistos com empatia e profissionalismo.
                    - Manter postura e apresentação impecáveis, alinhadas ao padrão da casa.
                    """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var responsabilitiesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [responsibilitiesLabel, responsibilitiesText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var requirementsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Requisitos:"
        return label
    }()
    
    private lazy var requirementsText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = """
            - Experiência em atendimento ou recepção em ambientes sofisticados (restaurantes, hotéis ou eventos).
            - Boa comunicação verbal e escrita.
            - Discrição, proatividade e organização.
            - Fluência em português. Desejável conhecimento em francês e/ou inglês.
            - Familiaridade com sistemas de reservas é um diferencial.
            """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var requirementsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [requirementsLabel, requirementsText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [imageView, companyStack, descriptionStack, responsabilitiesStack, requirementsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 13
        return stack
    }()
    
    private lazy var companyName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Le Cochon Volant:"
        return label
    }()
    
    private lazy var companyDescription: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restaurante especializado"
        return label
    }()
    
    private lazy var companyAddress: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R. Santo Inácio, 295 - Moinhos de Vento, Porto Alegre - RS"
        return label
    }()
    
    private lazy var companyNumberOfEmployees: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20-50 funcionários" // tem componente pra isso
        return label
    }()
    
    private lazy var postedDate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1h atrás" // tem componente pra isso
        return label
    }()
    
    lazy var companyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [companyName, companyDescription, companyNumberOfEmployees, companyAddress, postedDate])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
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
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.systemGray5
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [contactButton, shareButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Recepcionista"

        setup()
        view.backgroundColor = .systemGray6
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "...",
                style: .plain,
                target: self,
                action: #selector(didTapRightButton)
            )
        
        configureViewWithData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Methods
    
    @objc private func didTapRightButton() {
        // Open denunciar alert
    }
    
    func configure(with jobOffer: JobOffer) {
        self.jobOffer = jobOffer
    }
    
    private func configureViewWithData() {
        guard let job = jobOffer else {
            return }
        
//        navigationController?.title = job.position.rawValue.capitalized
        descriptionText.text = job.description
        requirementsText.text = job.requirements
        responsibilitiesText.text = job.responsibilities
    }
    
    @objc private func openWhatsApp() {
        let alert = UIAlertController(title: "Register Interest", message: "Obrigado por se candidatar, seu perfil já está com o contratante. Agora é só dar o próximo passo.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entrar em contato", style: .default) { _ in if let url = URL(string: "https://wa.me/+5551997645781?text=Oi%2C%20vi%20o%20an%C3%BAncio%20da%20vaga%20no%20%2AFreela%20onTap%2A%20e%20gostaria%20de%20me%20candidatar.") {  UIApplication.shared.open(url, options: [:], completionHandler: nil)}
        })
        alert.addAction(UIAlertAction(title: "Talvez mais tarde", style: .default))
        present(alert, animated: true)
    }
}

extension JobDetailsViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStack)
        contentView.addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
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
                       
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            contactButton.widthAnchor.constraint(equalToConstant: 247),
            contactButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            buttonsStack.topAnchor.constraint(equalTo: requirementsStack.bottomAnchor, constant: 30),
            buttonsStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 59)
        ])
    }
}
