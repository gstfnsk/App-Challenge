//
//  EmptyState.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 20/06/25.
//

import UIKit
import SwiftUI

class EmptyState: UIView {
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.DesignSystem.title3
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Nenhuma vaga no radar"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.DesignSystem.subheadline
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.text = """
        Fique de olho, novas oportunidades chegam
        o tempo todo. Tente novamente mais tarde
        ou ajuste seus filtros 🤞
        """
        return label
    }()
    
    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "tray")
        imageView.tintColor = UIColor.DesignSystem.terracota300
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.DesignSystem.lavanda0
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyState: ViewCodeProtocol {
    func addSubviews() {
        addSubview(imageView)
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: 186),
            imageView.widthAnchor.constraint(equalToConstant: 393),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -210),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
