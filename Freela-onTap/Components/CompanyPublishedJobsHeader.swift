//
//  CompanyPublishedJobsHeader.swift
//  App-Challenge
//
//

import UIKit

class CompanyPublishedJobsHeader: UICollectionViewCell {
    // MARK: - Public Properties
    // Add public properties here to configure the component
    static let identifier = "CompanyPublishedJobsHeader"

    var text = "Label" {
        didSet {
            headerLabel.text = text
        }
    }

    var icon: UIImage? {
        didSet {
            headerIcon.isHidden = (icon == nil)
            headerIcon.image = icon
            headerIcon.image?.withTintColor(.DesignSystem.terracota600)
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    // MARK: - Private Methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements
    // Declare your UI elements here (e.g., labels, images, buttons)

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Abertas"
        label.font = .DesignSystem.body
        label.textColor = .label
        return label
    }()

    private lazy var headerIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)

        imageView.image = UIImage(systemName: "info.circle", withConfiguration: config)?
            .withTintColor(.DesignSystem.terracota600, renderingMode: .alwaysOriginal)

        imageView.contentMode = .scaleAspectFit

        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()

    private lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, headerIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill

        return stackView
    }()

    private lazy var bottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
}

// MARK: - ViewCodeProtocol
extension CompanyPublishedJobsHeader: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(stack)
        contentView.addSubview(bottomBorder)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerIcon.heightAnchor.constraint(equalToConstant: 25),
            headerIcon.widthAnchor.constraint(equalToConstant: 25),

            heightAnchor.constraint(equalToConstant: 60),

            bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

#Preview {
    CompanyPublishedJobsHeader()
}
