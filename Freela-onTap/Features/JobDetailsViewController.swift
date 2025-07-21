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
        label.applyDynamicFont(.DesignSystem.title2Emphasized)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição da vaga:"
        label.applyDynamicFont(UIFont.DesignSystem.headline)
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
        label.applyDynamicFont(UIFont.DesignSystem.body)
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
        label.applyDynamicFont(UIFont.DesignSystem.headline)
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
        label.applyDynamicFont(UIFont.DesignSystem.body)
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
        label.applyDynamicFont(UIFont.DesignSystem.headline)
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
        label.applyDynamicFont(UIFont.DesignSystem.body)
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
        label.applyDynamicFont(UIFont.DesignSystem.title2Emphasized)
        return label
    }()

    private lazy var establishmentType: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bar"
        label.applyDynamicFont(UIFont.DesignSystem.body)
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        return label
    }()

    private lazy var companyAddress: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyDynamicFont(UIFont.DesignSystem.footnote)
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
        label.text = "10-20 funcionários"
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

    private lazy var contactButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registrar interesse na vaga", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.DesignSystem.terracota500
        button.addTarget(self, action: #selector(openWhatsApp), for: .touchUpInside)
        return button
    }()

    private lazy var blurredBackgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        //        backgroundView.backgroundColor = UIColor.systemBackground
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
        BadgeLabelWithIcon(
            text: "27/06",
            state: .mutted,
            size: .medium
        )
    }()

    private lazy var time: BadgeLabelWithIcon = {
        BadgeLabelWithIcon(
            text: "Horário: 18h",
            state: .mutted,
            size: .medium
        )
    }()

    private lazy var amount: BadgeLabelWithIcon = {
        BadgeLabelWithIcon(
            text: "R$ 120",
            state: .mutted,
            size: .medium
        )
    }()

    private lazy var duration: BadgeLabelWithIcon = {
        BadgeLabelWithIcon(
            text: "6h",
            state: .mutted,
            size: .medium
        )
    }()

    lazy var badgesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [date, time, amount, duration])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        return stack
    }()

    private lazy var shareButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.DesignSystem.terracota200
        button.layer.cornerRadius = 12
        button.addTarget(self.jobOffer, action: #selector(shareButtonTapped), for: .touchUpInside)
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

        // TODO: ellipsis button (MVP+)
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(
        //                image: UIImage(systemName: "ellipsis"),
        //                style: .plain,
        //                target: self,
        //                action: #selector(didTapRightButton)
        //            )

        configureViewWithData()
        // Do any additional setup after loading the view.
    }

    // MARK: Methods

    @objc private func didTapRightButton() {
        // Open denunciar alert
    }
    
    @objc private func shareButtonTapped() {
        let texto = "“Vi que estão buscando \(jobOffer?.title.rawValue.localizedCapitalized ?? "") no Freela onTap! Pode ser uma boa pra você."
        let activityVC = UIActivityViewController(activityItems: [texto, "https://testflight.apple.com/join/fhWYxupt"], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    func configure(with jobOffer: JobOffer) {
        self.jobOffer = jobOffer
    }

    private func configureViewWithData() {
        guard let jobOffer else {
            self.navigationController?.popViewController(animated: true)
            return
        }

        guard let company = jobOffer.company else {
            let errorAlert = UIAlertController(
                title: "Erro",
                message: "Não foi possivel carregar os dados da oferta. Por favor, tente novamente mais tarde.",
                preferredStyle: .alert
            )
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            return
        }

        title = jobOffer.title.rawValue.localizedCapitalized

        companyName.text = company.name
        establishmentType.text = company.establishmentType.rawValue.localizedCapitalized
        companyNumberOfEmployees.text = company.companySize.rawValue

        companyAddress.text =
        company.address.streetAndNumber + ", " + company.address.neighborhood + ", " + company.address.cityAndState
        postedTime.text = jobOffer.postedAt.timeAgoString()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        date.text = dateFormatter.string(from: jobOffer.startDate)

        dateFormatter.dateFormat = "HH'h'mm"
        time.text = "Horário: \(dateFormatter.string(from: jobOffer.startDate))"

        amount.text = "R$ \(jobOffer.salaryBRL)"
        duration.text = "\(jobOffer.durationInHours)h"

        descriptionText.text = jobOffer.description
        dutiesText.text = jobOffer.duties
        requirementsText.text = jobOffer.qualifications

        companyImageView.image = company.profileImage ?? UIImage(named: "placeholder")
    }

    @objc private func openInMaps() {
        let address = companyAddress.text ?? ""
        
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "http://maps.apple.com/?q=\(encodedAddress)") {
            UIApplication.shared.open(url)
        }
    }

    @objc private func openWhatsApp() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        // Title: bold + terracota600
        let attributedTitle = NSAttributedString(
            string: "Agora é com você!!",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.DesignSystem.bodyEmphasized
            ]
        )
        alert.setValue(attributedTitle, forKey: "attributedTitle")

        // Message: regular + terracota600
        let attributedMessage = NSAttributedString(
            string: "Fale direto com quem tá contratando e garanta seu freela",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.DesignSystem.body
            ]
        )
        alert.setValue(attributedMessage, forKey: "attributedMessage")

        // Actions

        let contactAction = UIAlertAction(title: "Entrar em contato", style: .default) { _ in
            if let url = URL(
                string:
                    "https://wa.me/+5551997645781?text=Oi%2C%20vi%20o%20an%C3%BAncio%20da%20vaga%20no%20%2AFreela%20onTap%2A%20e%20gostaria%20de%20me%20candidatar."
            ) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        contactAction.setValue(UIColor.DesignSystem.terracota600, forKey: "titleTextColor")

        let laterAction = UIAlertAction(title: "Talvez mais tarde", style: .default)
        laterAction.setValue(UIColor.DesignSystem.terracota600, forKey: "titleTextColor")

        alert.addAction(contactAction)
        alert.addAction(laterAction)

        present(alert, animated: true)
    }
}

extension JobDetailsViewController: ViewCodeProtocol {
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

            contactButton.widthAnchor.constraint(equalToConstant: 321),
            contactButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            buttonsStack.widthAnchor.constraint(equalToConstant: 321),

            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -31.5),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),

            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 59)
        ])
    }
}
