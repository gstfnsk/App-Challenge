//
//  JobRegistration2.swift
//  Freela-onTap
//
//  Created by Gustavo Ferreira bassani on 25/06/25.
//

import UIKit

class JobRegister2ViewController: UIViewController {
    var jobOffer: JobOffer?
    // //MARK: GAMBIARRA PRA DEPOIS
    var begginingHour: Date?
    var begginingDate: Date?
    
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .DesignSystem.terracota600
        return view
    }()
    // virá do cadastro de empresa
    private lazy var companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "TestFlightPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var imageContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 4
        container.clipsToBounds = true

        container.addSubview(companyImageView)

        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: container.topAnchor),
            companyImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            companyImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            companyImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        return container
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    

    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição da vaga:"
        label.font = UIFont.DesignSystem.headline
        return label
    }()
    
    // certinho
    private lazy var descriptionText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        if let jobOffer {
            label.text = jobOffer.description
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        label.font = UIFont.DesignSystem.body
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
        label.font = UIFont.DesignSystem.headline
        return label
    }()

    private lazy var dutiesText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        if let jobOffer {
            label.text = jobOffer.duties
        }
        
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.DesignSystem.body
        return label
    }()

    private lazy var responsabilitiesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [responsibilitiesLabel, dutiesText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var requirementsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Requisitos:"
        label.font = UIFont.DesignSystem.headline
        return label
    }()
    
    // certinho
    private lazy var requirementsText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        if let jobOffer {
            label.text = jobOffer.duties
        }
        
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.DesignSystem.body
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
        var stack = UIStackView(arrangedSubviews: [descriptionStack, responsabilitiesStack, requirementsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 13
        return stack
    }()
    // MARK: VEM DO CADASTRO DA EMPRESA
    private lazy var companyName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunset Drinks"
        label.textColor = UIColor.DesignSystem.terracota900
        label.font = UIFont.DesignSystem.title2Emphasized
        return label
    }()
    
    // MARK: VEM DO CADASTRO DA EMPRESA
    private lazy var establishmentType: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restaurante"
        label.font = UIFont.DesignSystem.body
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        return label
    }()
    // MARK: VEM DO CADASTRO DA EMPRESA
    private lazy var companyAddress: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.DesignSystem.footnote
        label.textColor = UIColor.DesignSystem.terracota600
        label.text = "R. Osvaldo Aranha, 1088 - loja 107. Petrópolis, Porto Alegre"
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInMaps))
        label.addGestureRecognizer(tapGesture)

        return label
    }()
    // MARK: VEM DO CADASTRO DA EMPRESA
    private lazy var companyNumberOfEmployees: LabelWithIconComponent = {
        var label = LabelWithIconComponent()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20-50 funcionários"
        label.imageColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        label.image = UIImage(systemName: "person.3")
        return label
    }()


    lazy var companyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            companyName, establishmentType, companyNumberOfEmployees, companyAddress
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()

    private lazy var blurredBackgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 16
        backgroundView.clipsToBounds = true
        backgroundView.addSubview(overlayView)

        return backgroundView
    }()

    private lazy var overlayView: UIView = {
        let view = GradientOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // certinho
    private lazy var date: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        if let jobOffer {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            let formattedDate = formatter.string(from: begginingDate ?? Date())
            badge.text = formattedDate
        }
        badge.badgeSize = .medium
        return badge
    }()

    // ESSE CARA E O HORARIO QUE COMEÇA
    private lazy var time: BadgeLabelWithIcon = {
        let badge = BadgeLabelWithIcon()
        
        // MARK: MUDAR AQUI
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let stringBeginningHour = formatter.string(from: begginingHour ?? Date())
        
        badge.text = stringBeginningHour
        badge.badgeSize = .medium
        return badge
    }()

    private lazy var amount: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        if let jobOffer {
            // MARK: MUDAR AQUI
            let stringSalary = String(jobOffer.salaryBRL)
            let text1 = "R$"
            let text2 = ",00"
            var fullText = ""
            fullText.append(text1)
            fullText.append(stringSalary)
            fullText.append(text2)
            badge.text = fullText
        }
        badge.badgeSize = .medium
        return badge
    }()
    
    // certinho
    private lazy var duration: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        if let jobOffer {
            let stringDuration = String(jobOffer.durationInHours)
            var durationWithH = ""
            durationWithH.append(stringDuration)
            durationWithH.append("h")
            badge.text = durationWithH
        }
        badge.badgeSize = .medium
        return badge
    }()

    lazy var badgesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [date, time, amount, duration])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        return stack
    }()

    private lazy var publishButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Publicar", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.DesignSystem.terracota500
        button.addTarget(self, action: #selector(saveDataAtCloudKit), for: .touchUpInside)
        return button
    }()
    
    private lazy var returnButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retornar e ajustar", for: .normal)
        button.setTitleColor(UIColor.DesignSystem.terracota600, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.DesignSystem.terracota0
        button.addTarget(self, action: #selector(saveDataAtCloudKit), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [publishButton, returnButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(begginingHour as Any)
        setup()
    }

    // MARK: Methods
    @objc func returnAction() { /* logic to return to registrationViewController */  }
    @objc func saveDataAtCloudKit() {
        /* logic to save data at cloudKit */
        let alert = UIAlertController(title: "Vaga publicada!", message: "tudo certo com o anúncio. Agora é só acompanhar as candidaturas!", preferredStyle: .alert)
        let alertActionOne = UIAlertAction(title: "ver vagas publicadas", style: .default) {_ in
            /* go to MyJobs */
        }
        alertActionOne.setValue(UIColor.DesignSystem.terracota600, forKey: "titleTextColor")
        let alertActionTwo = UIAlertAction(title: "Publicar outra vaga", style: .default) {_ in
            _ = JobRegisterViewController()
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertActionTwo.setValue(UIColor.DesignSystem.terracota600, forKey: "titleTextColor")

        alert.addAction(alertActionOne)
        alert.addAction(alertActionTwo)
        present(alert, animated: true)
    }
    @objc private func openInMaps() {
        let address = companyAddress.text ?? ""
        
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "http://maps.apple.com/?q=\(encodedAddress)") {
            UIApplication.shared.open(url)
        }
    }
    }


extension JobRegister2ViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(overlayView)
        view.addSubview(orangeView)
        overlayView.addSubview(buttonsStack)

        scrollView.addSubview(contentView)
        contentView.addSubview(imageContainerView)
        contentView.addSubview(companyStack)
        contentView.addSubview(badgesStack)
        contentView.addSubview(mainStack)
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

            imageContainerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 27),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageContainerView.heightAnchor.constraint(
                equalTo: imageContainerView.widthAnchor,
                multiplier: 196.0 / 361.0
            ),
            
            orangeView.heightAnchor.constraint(equalToConstant: 4),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orangeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            companyStack.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 16),
            companyStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            companyStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            badgesStack.topAnchor.constraint(equalTo: companyStack.bottomAnchor, constant: 16),
            badgesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            mainStack.topAnchor.constraint(equalTo: badgesStack.bottomAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            overlayView.heightAnchor.constraint(equalToConstant: 150),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            buttonsStack.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -34.5),
            
            publishButton.widthAnchor.constraint(equalToConstant: 321),
            publishButton.heightAnchor.constraint(equalToConstant: 50),
            
            returnButton.widthAnchor.constraint(equalToConstant: 321),
            returnButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStack.heightAnchor.constraint(equalToConstant: 112),
            buttonsStack.widthAnchor.constraint(equalToConstant: 321)
        ])
    }
    
    func setupAdditionalConfiguration() {
        title = "cadastro de vagas"
        view.backgroundColor = .systemGray6
    }
}
