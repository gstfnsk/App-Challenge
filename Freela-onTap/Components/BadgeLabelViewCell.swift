//
//  BadgeLabelViewCell.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 17/06/25.
//
import UIKit

class BadgeLabelViewCell: UICollectionViewCell {
    private lazy var badge: BadgeLabelWithIcon = {
        let badge = BadgeLabelWithIcon()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.backColor = .systemBackground
        return badge
    }()
    
    // MARK: Properties
    static let identifier = "badgeCollectionCell"
    
    // MARK: Functions
    func configure(title: String, imageName: String) {
        badge.icon = UIImage(systemName: imageName)
        badge.text = title
    }
    
    func cellJob() -> JobPosition {
        let jobText = badge.text
        return JobPosition(rawValue: jobText) ?? .other
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
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }

    private func setupContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    func setSelectedStyle() {
        badge.backColor = .DesignSystem.terracota600
        badge.featureColor = .white
    }
    func setDeselectedStyle() {
        badge.backColor = .systemBackground
        badge.featureColor = .DesignSystem.terracota600
    }
}

extension BadgeLabelViewCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(badge)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            badge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            badge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            badge.topAnchor.constraint(equalTo: contentView.topAnchor),
            badge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
