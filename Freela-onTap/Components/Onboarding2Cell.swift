//
//  Onboarding2Cell.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 18/06/25.
//

import UIKit

final class Onboarding2Cell: UICollectionViewCell {
    // MARK: - Public Properties
    static let identifier = "onboarding2-identifies"

    // MARK: - UI Elements
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40) // not dynamic
        label.numberOfLines = 0
        label.textColor = UIColor.DesignSystem.terracota600
        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17) // not dynamic
        label.numberOfLines = 0
        label.textColor = UIColor.DesignSystem.terracota900
        return label
    }()

    private lazy var phoneImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configure(title: NSAttributedString, subtitle: String, imageName: String) {
        self.mainTitle.attributedText = title
        self.subtitle.text = subtitle
        self.phoneImage.image = UIImage(named: imageName)
    }
}

// MARK: - ViewCodeProtocol
extension Onboarding2Cell: ViewCodeProtocol {
    // MARK: - Add Subviews
    func addSubviews() {
        addSubview(phoneImage)
        addSubview(mainTitle)
        addSubview(subtitle)
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainTitle.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -175),
            mainTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            mainTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),

            subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 41),
            subtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -164),

            phoneImage.topAnchor.constraint(equalTo: self.topAnchor),
            phoneImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            phoneImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            phoneImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - Additional Configuration
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
