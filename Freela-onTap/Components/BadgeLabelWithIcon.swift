//
//  BadgeLabelWithIcon.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 12/06/25.
//

import UIKit

final class BadgeLabelWithIcon: UIView {
    enum JobCellState: CaseIterable {
        case normal, mutted, white, transparent, disabled
    }

    enum BadgeSize: Float {
        case small = 22
        case medium = 34
    }

    // MARK: - Public Properties
    // Add public properties here to configure the component

    var state: JobCellState = .normal {
        didSet {
            updateBasedOnState()
        }
    }

    var badgeSize: BadgeSize = .small {
        didSet {
            updateBadgeSize()
        }
    }

    var text: String? {
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
    
    var systemImageName: String? {
        didSet {
            if let systemImageName {
                let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
                icon = UIImage(systemName: systemImageName, withConfiguration: config)
            }
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

    convenience init(text: String, icon: UIImage? = nil, state: JobCellState = .normal, size: BadgeSize = .small) {
        self.init(frame: .zero)

        self.text = text
        self.icon = icon
        self.state = state
        setup()
    }
    
    convenience init(text: String, systemImageName: String, state: JobCellState = .normal, size: BadgeSize = .small) {
        self.init(frame: .zero)

        self.text = text
        self.state = state
        self.systemImageName = systemImageName
        setup()
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

    private func updateBasedOnState() {
        switch state {
        case .normal:
            self.backgroundColor = .DesignSystem.terracota500
            self.textLabel.textColor = .DesignSystem.terracota0
            self.iconView.tintColor = .DesignSystem.terracota0
        case .mutted:
            self.backgroundColor = .DesignSystem.terracota100
            self.textLabel.textColor = .DesignSystem.terracota700
            self.iconView.tintColor = .DesignSystem.terracota700
        case .white:
            self.backgroundColor = .DesignSystem.terracota0
            self.textLabel.textColor = .DesignSystem.terracota700
            self.iconView.tintColor = .DesignSystem.terracota700
        case .transparent:
            self.backgroundColor = .clear
            self.textLabel.textColor = .DesignSystem.terracota700
            self.iconView.tintColor = .DesignSystem.terracota700
        case .disabled:
            self.backgroundColor = .quaternarySystemFill
            self.textLabel.textColor = .tertiaryLabel
            self.iconView.tintColor = .tertiaryLabel
        }
        
        changeShadowState(state == .white)
    }
    
    private func changeShadowState(_ enableShadow: Bool) {
        layer.shadowColor = enableShadow ? UIColor.black.cgColor : UIColor.clear.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }

    // MARK: - UI Elements
    // Declare your UI elements here (e.g., labels, images, buttons)
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.applyDynamicFont(.DesignSystem.subheadline)
        label.textColor = .label
        return label
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
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
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            iconView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: - Additional Configuration

    func setupAdditionalConfiguration() {
        updateBadgeSize()
        updateBasedOnState()
        setContentHuggingPriority(.required, for: .vertical)
    }
}

#Preview {
    let withIconColumn = UIStackView()
    withIconColumn.axis = .vertical
    withIconColumn.spacing = 8
    withIconColumn.alignment = .center

    let withoutIconColumn = UIStackView()
    withoutIconColumn.axis = .vertical
    withoutIconColumn.spacing = 8
    withoutIconColumn.alignment = .center

    for state in BadgeLabelWithIcon.JobCellState.allCases {
        let withIcon = BadgeLabelWithIcon()
        withIcon.state = state
        withIcon.badgeSize = .medium
        withIcon.systemImageName = "person.2"
        withIcon.text = "\(state)".capitalized

        let withoutIcon = BadgeLabelWithIcon()
        withoutIcon.state = state
        withoutIcon.badgeSize = .medium
        withoutIcon.text = "\(state)".capitalized

        withIconColumn.addArrangedSubview(withIcon)
        withoutIconColumn.addArrangedSubview(withoutIcon)
    }

    let horizontalStack = UIStackView(arrangedSubviews: [withIconColumn, withoutIconColumn])
    horizontalStack.axis = .horizontal
    horizontalStack.spacing = 24
    horizontalStack.alignment = .top

    return horizontalStack
}
