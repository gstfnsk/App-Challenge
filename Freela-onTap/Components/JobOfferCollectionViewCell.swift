//
//  JobOfferCollectionViewCell.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 12/06/25.
//

import UIKit

class JobOfferCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties
    // Add public properties here to configure the component
    static let identifier = #file

    enum JobCellState {
        case normal, highlighted, disabled, filled, open
    }

    func configure(job: JobOffer) {
        titleLabel.text = job.title.rawValue.localizedCapitalized.replacingOccurrences(of: " De ", with: " de ")
        time.text = job.postedAt.timeAgoString()

        descriptionLabel.text = job.company?.establishmentType.rawValue.localizedCapitalized ?? "Desconhecido"
        location.text = job.company?.address.cityAndState ?? "Desconhecido"

        // TODO: In future, use real images
        imageView.image = UIImage(
            named:
                "companyPhotos/\((job.company?.name ?? "").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "ô", with: "o"))"
        )
        
        setBadgesText([
            job.startDate.formatted("dd/MM"),
            "Horário: \(job.startDate.formatted("HH'h'mm"))",
            "R$ \(job.salaryBRL)",
            "\(job.durationInHours)h"
        ])
    }

    var state: JobCellState = .normal {
        didSet {
            updateBasedOnState()
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

    // MARK: - Private Methods
    private func updateBasedOnState() {
        switch state {
        case .filled:
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
            stateIcon.image = UIImage(systemName: "person.crop.circle.fill.badge.checkmark", withConfiguration: config)?
                .withTintColor(.DesignSystem.terracota600, renderingMode: .alwaysOriginal)
        case .open:
            stateIcon.image = UIImage(named: "person.crop.circle.fill.badge.magnifyingglass")
        case .normal:
            break
        default:
            assertionFailure("Unhandled state: \(state) on \(#file)")
        }
        
        stateIcon.isHidden = state != .filled && state != .open
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }

    private func setupContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
    
    private func setBadgesText(_ texts: [String]){
        badgeStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for text in texts {
            let badgeView = BadgeLabelWithIcon(text: text)

            badgeStack.addArrangedSubview(badgeView)
        }
        
        badgeStack.addArrangedSubview(UIView())
    }

    // MARK: - UI Elements
    // Declare your UI elements here (e.g., labels, images, buttons)
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "DefaultRestaurantPhoto")

        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var stateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .DesignSystem.terracota600
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recepcionista"
        label.font = .DesignSystem.title3Emphasized
        label.textColor = .DesignSystem.terracota900
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Restaurante"
        label.font = .DesignSystem.footnote
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return stackView
    }()

    private lazy var imageStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, labelStackView, stateIcon])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var iconStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [time, location])
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var badgeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
//        stack.distribution = .equalSpacing
        stack.spacing = 8

        return stack
    }()

    private lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageStack, badgeStack, iconStack])
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var time: LabelWithIconComponent = {
        let icon = LabelWithIconComponent()
        icon.image = UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        icon.text = "1h atrás"
        return icon
    }()

    private lazy var location: LabelWithIconComponent = {
        let icon = LabelWithIconComponent()
        icon.image = UIImage(systemName: "mappin")
        icon.text = "Porto Alegre / RS"
        return icon
    }()
}
extension JobOfferCollectionViewCell: ViewCodeProtocol {
    func setup(){
        addSubviews()
        setupConstraints()
        
        setupShadow()
        setupContentView()
        updateBasedOnState()
        setBadgesText(["Label", "Label"])
    }
    
    func addSubviews() {
        contentView.addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            imageView.heightAnchor.constraint(equalToConstant: 56),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            
            stateIcon.heightAnchor.constraint(equalToConstant: 50),
            stateIcon.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

#Preview {
    let cell = JobOfferCollectionViewCell()
    cell.state = .open
    
    /// Ignore lines bellow, the are only for the pourpuse of this preview
    cell.translatesAutoresizingMaskIntoConstraints = false

    cell.setNeedsLayout()
    cell.layoutIfNeeded()

    let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

    let container = UIView()
    container.backgroundColor = .systemBackground
    container.translatesAutoresizingMaskIntoConstraints = false

    container.addSubview(cell)

    NSLayoutConstraint.activate([
        container.widthAnchor.constraint(equalToConstant: 325),
        container.heightAnchor.constraint(equalToConstant: 812),

        cell.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        cell.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        cell.widthAnchor.constraint(equalToConstant: size.width + 60),
        cell.heightAnchor.constraint(equalToConstant: size.height)
    ])

    return container
}
