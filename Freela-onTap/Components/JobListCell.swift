//
//  JobListCell.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 12/06/25.
//
import UIKit
class JobListCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "DefaultRestaurantPhoto")
        
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recepcionista"
        label.font = .DesignSystem.title3
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
        return stackView
    }()
    private lazy var imageStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ imageView, labelStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var iconStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ time, location])
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let badges = [BadgeLabelWithIcon(), BadgeLabelWithIcon(), BadgeLabelWithIcon(), BadgeLabelWithIcon()]
    
    // TODO: Change placeholders with real data! Maybe use a collection view with flow layout
    private lazy var badgeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: badges)
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageStack, badgeStack, iconStack])
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.alignment = .leading
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
    
    // MARK: Properties
    static let identifier = "JobListCell"
    
    
    func configure(job: JobOffer) {
        titleLabel.text = job.title.rawValue.localizedCapitalized
        time.text = job.postedAt.timeAgoString()

        descriptionLabel.text = job.company?.establishmentType.rawValue.localizedCapitalized ?? "Desconhecido"
        location.text = job.company?.address.cityAndState ?? "Desconhecido"

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        badges[0].text = dateFormatter.string(from: job.startDate)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH'h'mm"
        badges[1].text = "Horário: \(timeFormatter.string(from: job.startDate))"
        
        badges[2].text = "R$ \(job.salaryBRL)"
        badges[3].text = "\(job.durationInHours)h"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupShadow()
        setupContentView()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupShadow()
        setupContentView()
        setup()
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
}
extension JobListCell: ViewCodeProtocol {
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
            imageView.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
}
