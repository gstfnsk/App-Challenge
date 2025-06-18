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
        image.tintColor = UIColor.DesignSystem.terracota600
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.setContentCompressionResistancePriority(.required, for: .horizontal)

        return image
    }()
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.font = UIFont.DesignSystem.footnote
        label.text = "1h atrás"
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var labelWihIcon: UIStackView = {
        var labelWihIcon = UIStackView(arrangedSubviews: [icon, label])
        labelWihIcon.alignment = .center
        labelWihIcon.distribution = .fill
        labelWihIcon.spacing = 4
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
    
    var imageColor: UIColor? {
        didSet {
            icon.tintColor = imageColor
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
            labelWihIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            icon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

#Preview {
    let blabel = LabelWithIconComponent()
    blabel.translatesAutoresizingMaskIntoConstraints = false
    blabel.text = "1h atrás"
    blabel.image = UIImage(systemName: "clock.arrow.circlepath")
    return blabel
}
