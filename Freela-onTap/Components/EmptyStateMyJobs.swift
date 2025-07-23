//
//  EmptyStateMyJobs.swift
//  Freela-onTap
//
//  Created by Gustavo Ferreira Bassani on 24/06/25.
//

import UIKit

final class EmptyStateCompanyJobs: UIView {
    // MARK: - UI Elements

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "tray")
        image.tintColor = UIColor.DesignSystem.terracota300
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nenhuma vaga anunciada ainda"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.labelsPrimary
        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "comece agora a divulgar oportunidades e conecte-se com freelancers prontos para somar no seu time"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.labelsSecondary
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.DesignSystem.terracota600
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        let title = NSAttributedString(string: "Divulgar minha primeira vaga", attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        button.clipsToBounds = true
        button.setTitleColor(UIColor.DesignSystem.terracota0, for: .normal)
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }
}

extension EmptyStateCompanyJobs: ViewCodeProtocol {
    // MARK: - Add Subviews

    func addSubviews() {
        addSubview(imageView)
        addSubview(mainTitle)
        addSubview(subtitle)
        addSubview(button)
    }

    // MARK: - Setup Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 259),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 114),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -114),
            imageView.heightAnchor.constraint(equalToConstant: 117),

            mainTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            mainTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43.5),
            mainTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43.5),

            subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 3),
            subtitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subtitle.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 32),
            subtitle.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -32),

            button.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 50),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Additional Configuration

    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
