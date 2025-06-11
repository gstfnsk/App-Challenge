//
//  LabelWithIconComponent.swift
//  UIKitChallenge-CollectionView
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//
import UIKit

class LabelWithIconComponent: UIView {
    private lazy var icon: UIImageView = {
        var image = UIImageView()
        image = UIImageView(image: UIImage(systemName: "person"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .secondaryLabel
        return image
    }()
    private lazy var label: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "1h atrás"
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var labelWihIcon: UIStackView = {
        var labelWihIcon = UIStackView(arrangedSubviews: [icon, label])
        labelWihIcon.alignment = .leading
        labelWihIcon.spacing = 8
        labelWihIcon.translatesAutoresizingMaskIntoConstraints = false
        return labelWihIcon
    }()
    
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    var image: UIImage? {
        didSet {
            icon.image = image
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LabelWithIconComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(labelWihIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelWihIcon.topAnchor.constraint(equalTo: self.topAnchor),
            labelWihIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelWihIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelWihIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
}

