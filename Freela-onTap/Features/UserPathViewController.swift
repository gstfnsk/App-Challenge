//
//  UserPathViewController.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 23/06/25.
//

import UIKit
import SwiftUI

class UserPathViewController: UIViewController {
    lazy var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O que você está buscando hoje?"
        label.textAlignment = .center
        label.font = UIFont.DesignSystem.title3SemiBold
        label.textColor = UIColor.labelsSecondary
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bell")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var iconText: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bell")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [icon, iconText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.DesignSystem.terracota0
        setup()
    }
}

extension UserPathViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(label)
        view.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
    }
}

#Preview {
    let test = UIViewController()
    return test
}
