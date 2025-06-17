//
//  BadgeLabelViewCell.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 17/06/25.
//
import UIKit

class BadgeLabelViewCell: UICollectionViewCell {
    private lazy var baged: BadgeLabelWithIcon = {
        let baged = BadgeLabelWithIcon()
        baged.translatesAutoresizingMaskIntoConstraints = false
        baged.backColor = .systemBackground
        return baged
    }()
    
    // MARK: Properties
    static let identifier = "badgeCollectionCell"
    
    // MARK: Functions
    func configure(title: String, imageName: String) {
        baged.icon = UIImage(systemName: imageName)
        baged.text = title
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
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
}

extension BadgeLabelViewCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(baged)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            baged.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baged.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            baged.topAnchor.constraint(equalTo: contentView.topAnchor),
            baged.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
