//
//  BadgeLabelWithIcon.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 12/06/25.
//

import UIKit

final class BadgeLabelWithIcon: UIView {
    // MARK: - Public Properties
    // Add public properties here to configure the component
    enum BadgeSize: Float {
        case small = 22
        case medium = 34
    }

    var badgeSize: BadgeSize = .small {
        didSet {
            updateBadgeSize()
        }
    }

    var text = "Label" {
        didSet {
            textLabel.text = text
        }
    }

    var icon: UIImage? {
        didSet {
            iconView.isHidden = (icon == nil)
            iconView.image = icon
        }
    }

    // use default backgroundColor from UIView

    var featureColor: UIColor = .systemBlue {
        didSet {
            textLabel.textColor = featureColor
            iconView.tintColor = featureColor
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }
    
    convenience init(text: String, icon: UIImage? = nil, size: BadgeSize = .small) {
        self.init(frame: .zero)
        
        self.text = text
        self.icon = icon
    }

    // MARK: - Private Methods
    private var badgeHeightConstraint: NSLayoutConstraint?

    private func updateBadgeSize() {
        layer.cornerRadius = CGFloat(badgeSize.rawValue / 2)

        if let existingConstraint = badgeHeightConstraint {
            self.removeConstraint(existingConstraint)
        }

        let newHeightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(badgeSize.rawValue))
        newHeightConstraint.isActive = true
        badgeHeightConstraint = newHeightConstraint
    }

    // MARK: - UI Elements
    // Declare your UI elements here (e.g., labels, images, buttons)
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, textLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
}

extension BadgeLabelWithIcon: ViewCodeProtocol {
    // MARK: - Add Subviews

    func addSubviews() {
        addSubview(stackView)
    }

    // MARK: - Setup Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            iconView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        updateBadgeSize()
    }

    // MARK: - Additional Configuration

    func setupAdditionalConfiguration() {
        self.text = "Label"
        self.icon = nil

        textLabel.textColor = featureColor
        iconView.tintColor = featureColor

        backgroundColor = .tertiarySystemFill
        
        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

#Preview {
    let blabel = BadgeLabelWithIcon()
    blabel.icon = UIImage(systemName: "figure.walk")
    blabel.badgeSize = .medium
    blabel.text = "Garçom"
    
    let blabel2 = BadgeLabelWithIcon()
    blabel2.text = "Medium"
    blabel2.badgeSize = .medium
    
    let blabel3 = BadgeLabelWithIcon()

    let stack = UIStackView(arrangedSubviews: [blabel, blabel2, blabel3])
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 8
    
    return stack
}
