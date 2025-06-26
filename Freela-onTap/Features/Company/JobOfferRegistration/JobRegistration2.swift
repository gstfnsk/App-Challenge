//
//  JobRegistration2.swift
//  Freela-onTap
//
//  Created by Gustavo Ferreira bassani on 25/06/25.
//

import UIKit

class JobRegister2ViewController: UIViewController {
    // receive a job offer from
    let jobOffer: JobOffer? = nil
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        label.font = UIFont.DesignSystem.headline
        return label
    }()

    private lazy var descriptionText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = """
            Estamos buscando um(a) atendente para atuar em nosso bar, oferecendo um atendimento descontraído, ágil e de qualidade. Ideal para quem busca uma renda extra e gosta de trabalhar em ambientes animados e com contato direto com o público.
            """
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
        label.text = """
            - Receber e atender os clientes com simpatia
            - Anotar pedidos e servir bebidas e petiscos
            - Organizar mesas e balcão
            - Auxiliar na organização do espaço durante o turno
            - Manter o ambiente limpo e agradável
            """
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

    private lazy var requirementsText: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = """
            - Maior de 18 anos
            - Experiência prévia em atendimento, bar ou eventos (desejável)
            - Boa comunicação e proatividade
            - Disponibilidade para trabalhar no período noturno e finais de semana
            - Agilidade e organização
            """
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

    private lazy var companyName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunset Drinks"
        label.textColor = UIColor.DesignSystem.terracota900
        label.font = UIFont.DesignSystem.title2Emphasized
        return label
    }()

    private lazy var establishmentType: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restaurante"
        label.font = UIFont.DesignSystem.body
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        return label
    }()

    private lazy var companyAddress: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.DesignSystem.footnote
        label.textColor = UIColor.DesignSystem.terracota600
        label.text = "Av. Beira-Mar, 1250 - Bairro Praia Norte, Florianópolis - SC"
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInMaps))
        label.addGestureRecognizer(tapGesture)

        return label
    }()
    

    private lazy var companyNumberOfEmployees: LabelWithIconComponent = {
        var label = LabelWithIconComponent()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20-50 funcionários"
        label.imageColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        label.image = UIImage(systemName: "person.3")
        return label
    }()

    private lazy var postedTime: LabelWithIconComponent = {
        var label = LabelWithIconComponent()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1h atrás"
        label.image = UIImage(systemName: "clock.arrow.circlepath")
        return label
    }()

    lazy var companyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            companyName, establishmentType, companyNumberOfEmployees, companyAddress, postedTime
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

    private lazy var date: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        badge.text = "27/06"
        badge.badgeSize = .medium
        return badge
    }()

    private lazy var time: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        badge.text = "Horário: 18h"
        badge.badgeSize = .medium
        return badge
    }()

    private lazy var amount: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        badge.text = "R$ 120"
        badge.badgeSize = .medium
        return badge
    }()

    private lazy var duration: BadgeLabelWithIcon = {
        var badge = BadgeLabelWithIcon()
        badge.text = "6h"
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
            /* go to JobsRegister */
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
        view.addSubview(buttonsStack)
        view.addSubview(overlayView)
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

            companyStack.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 16),
            companyStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            companyStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            badgesStack.topAnchor.constraint(equalTo: companyStack.bottomAnchor, constant: 16),
            badgesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            mainStack.topAnchor.constraint(equalTo: badgesStack.bottomAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -110),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            overlayView.heightAnchor.constraint(equalToConstant: 113),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            publishButton.widthAnchor.constraint(equalToConstant: 321),
            publishButton.heightAnchor.constraint(equalToConstant: 50),
            
            returnButton.widthAnchor.constraint(equalToConstant: 321),
            returnButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStack.heightAnchor.constraint(equalToConstant: 112),
            buttonsStack.widthAnchor.constraint(equalToConstant: 321),

            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -31.5),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36)
        ])
    }
    
    func setupAdditionalConfiguration() {
        title = "cadastro de vagas"
        view.backgroundColor = .systemGray6
    }
}
