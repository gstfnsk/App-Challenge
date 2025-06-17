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
        return baged
    }()
    
    // MARK: Properties
    static let identifier = "badgeCollectionCell"
    
    // MARK: Functions
    func configure(title: String, imageName: String) {
        baged.icon = UIImage(systemName: imageName)
        baged.text = title
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

