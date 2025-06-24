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
    
    lazy var iconimage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icone")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var iconText: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [iconimage, iconText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 23
        return stack
    }()
    
    lazy var freelaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Encontrar um freela", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(freelaAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var companyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Contratar um freela", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(companyAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [freelaButton, companyButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.DesignSystem.terracota0
        setup()
    }
    @objc func freelaAction() {
        let jobList = JobListViewController()
//        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(jobList, animated: true)
    }
    
    @objc func companyAction() {
        let registerCompany = FirstScreenViewController()
        self.navigationController?.pushViewController(registerCompany, animated: true)
    }
}

extension UserPathViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(label)
        view.addSubview(stack)
        view.addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 92),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            iconimage.heightAnchor.constraint(equalToConstant: 138),
            iconimage.widthAnchor.constraint(equalToConstant: 138),
            
            iconText.heightAnchor.constraint(equalToConstant: 93),
            iconText.widthAnchor.constraint(equalToConstant: 200),
            
            label.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -26),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            freelaButton.heightAnchor.constraint(equalToConstant: 132),
            freelaButton.widthAnchor.constraint(equalToConstant: 361),
            
            companyButton.heightAnchor.constraint(equalToConstant: 132),
            companyButton.widthAnchor.constraint(equalToConstant: 361),
            
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

#Preview {
    let test = UserPathViewController()
    return test
}
