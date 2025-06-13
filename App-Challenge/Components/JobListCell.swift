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
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recepcionista"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Restaurante"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading // <- IMPORTANTE
        return stackView
    }()
    private lazy var imageStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ imageView, labelStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center // ou .leading, se quiser colar tudo no topo
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var iconStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ time, location])
        stackView.spacing = 16
        stackView.alignment = .leading // <- IMPORTANTE
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // TODO: Change placeholders with real data! Maybe use a collection view with flow layout
    private lazy var badgeStack: UIStackView = {
        let badges = [BadgeLabelWithIcon(), BadgeLabelWithIcon(), BadgeLabelWithIcon(), BadgeLabelWithIcon()]
        badges[0].text = "27/06"
        badges[1].text = "Horário: 11h30"
        badges[2].text = "R$ 80"
        badges[3].text = "5h"
        
        let stack = UIStackView(arrangedSubviews: badges)
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageStack, badgeStack, iconStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading // <- ESSENCIAL PRA TUDO FICAR COLADO À ESQUERDA
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
        // company = getAllCompany.last(where: { $0.id == job.companyId })
        titleLabel.text = job.position.rawValue
        // descriptionLabel.text = company.Establishment.rawvalue
        location.text = job.location
//        imageView.image = company.photo
        
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.tertiaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
