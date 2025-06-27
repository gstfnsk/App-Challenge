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

    init(
        text: String,
        icon: UIImage? = nil,
        systemImageName: String? = nil,
        state: JobCellState = .normal,
        size: BadgeSize = .small
    ) {
        self.text = text
        self.icon = icon
        self.systemImageName = systemImageName
        self.state = state
        self.badgeSize = size
        
        super.init(frame: .zero)
        
        setup()
    }

    // MARK: - Private Methods

    private var badgeHeightConstraint: NSLayoutConstraint?

    private func updateBadgeSize() {
        layer.cornerRadius = CGFloat(badgeSize.rawValue / 2)

        if let existingConstraint = badgeHeightConstraint {
            existingConstraint.isActive = false
        }

        let newHeightConstraint = heightAnchor.constraint(equalToConstant: CGFloat(badgeSize.rawValue))
        newHeightConstraint.isActive = true
        badgeHeightConstraint = newHeightConstraint
    }

    private func updateBasedOnState() {
        switch state {
        case .normal:
            backgroundColor = .DesignSystem.terracota500
            textLabel.textColor = .DesignSystem.terracota0
            iconView.tintColor = .DesignSystem.terracota0
        case .mutted:
            backgroundColor = .DesignSystem.terracota100
            textLabel.textColor = .DesignSystem.terracota700
            iconView.tintColor = .DesignSystem.terracota700
        case .white:
            backgroundColor = .DesignSystem.terracota0
            textLabel.textColor = .DesignSystem.terracota700
            iconView.tintColor = .DesignSystem.terracota700
        case .transparent:
            backgroundColor = .clear
            textLabel.textColor = .DesignSystem.terracota700
            iconView.tintColor = .DesignSystem.terracota700
        case .disabled:
            backgroundColor = .quaternarySystemFill
            textLabel.textColor = .tertiaryLabel
            iconView.tintColor = .tertiaryLabel
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

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.applyDynamicFont(.DesignSystem.subheadline)
        label.textColor = .label
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
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
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return stackView
    }()
}

// MARK: - ViewCodeProtocol
extension BadgeLabelWithIcon: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            iconView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupAdditionalConfiguration() {
        textLabel.text = text
        iconView.isHidden = (icon == nil)
        iconView.image = icon

        updateBadgeSize()
        updateBasedOnState()
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
//
//#Preview {
//    let withIconColumn = UIStackView()
//    withIconColumn.axis = .vertical
//    withIconColumn.spacing = 8
//    withIconColumn.alignment = .center
//
//    let withoutIconColumn = UIStackView()
//    withoutIconColumn.axis = .vertical
//    withoutIconColumn.spacing = 8
//    withoutIconColumn.alignment = .center
//
//    for state in BadgeLabelWithIcon.JobCellState.allCases {
//        let withIcon = BadgeLabelWithIcon()
//        withIcon.state = state
//        withIcon.badgeSize = .medium
//        withIcon.systemImageName = "person.2"
//        withIcon.text = "\(state)".capitalized
//
//        let withoutIcon = BadgeLabelWithIcon()
//        withoutIcon.state = state
//        withoutIcon.badgeSize = .medium
//        withoutIcon.text = "\(state)".capitalized
//
//        withIconColumn.addArrangedSubview(withIcon)
//        withoutIconColumn.addArrangedSubview(withoutIcon)
//    }
//
//    let horizontalStack = UIStackView(arrangedSubviews: [withIconColumn, withoutIconColumn])
//    horizontalStack.axis = .horizontal
//    horizontalStack.spacing = 24
//    horizontalStack.alignment = .top
//
//    return horizontalStack
//}
