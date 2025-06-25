//
//  ErrorEmptyState.swift
//  Freela-onTap
//
//  Created by Gustavo Ferreira bassani on 20/06/25.
//

import UIKit

final class ErrorEmptyStateJobBoard: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "brokedGlass")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Opa, rolou um erro aqui"
        label.textColor = UIColor.labelsPrimary
        label.textAlignment = .center
        label.applyDynamicFont(.DesignSystem.title3Emphasized)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tente recarregar ou volte daqui a pouco."
        label.textColor = UIColor.labelsSecondary
        label.textAlignment = .center
        label.applyDynamicFont(.DesignSystem.subheadline)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
}

extension ErrorEmptyStateJobBoard: ViewCodeProtocol {
    func addSubviews() {
        addSubview(image)
        addSubview(mainTitle)
        addSubview(subtitle)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 266),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            
            mainTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            mainTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43.5),
            mainTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43.5),
            
            subtitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 3),
            subtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43.5),
            subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43.5)
        ])
    }
    
    
    func setupAdditionalConfiguration() {
        backgroundColor = .DesignSystem.lavanda0
    }
}
