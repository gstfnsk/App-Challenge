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
    
    lazy var freelancerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .freelancer
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var freelancerText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Encontrar um freela"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.DesignSystem.terracota0
        return label
    }()
    
    lazy var freelaSubText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ganhe dinheiro"
        label.font = UIFont.DesignSystem.callout
        label.textColor = UIColor.DesignSystem.terracota0
        return label
    }()
    
    lazy var freelancerTextStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [freelancerText, freelaSubText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy var freelaStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [freelancerImageView, freelancerTextStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.backgroundColor = .DesignSystem.terracota600
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        return stack
    }()
    
    lazy var freelaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(freelaAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .empresa
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var companyText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contratar um freela"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.DesignSystem.terracota0
        return label
    }()
    
    lazy var companySubText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Monte sua equipe ideal"
        label.font = UIFont.DesignSystem.callout
        label.textColor = UIColor.DesignSystem.terracota0
        return label
    }()
    
    lazy var companyTextStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [companyText, companySubText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy var companyStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [companyImageView, companyTextStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.backgroundColor = .DesignSystem.terracota600
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        return stack
    }()
    lazy var companyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
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
        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(jobList, animated: true)
    }
    
    @objc func companyAction() {
        let registerCompany = FirstScreenViewController()
        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(registerCompany, animated: true)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
}

extension UserPathViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(label)
        view.addSubview(stack)
        view.addSubview(freelaStack)
        view.addSubview(companyStack)
        view.addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
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
            freelancerImageView.heightAnchor.constraint(equalToConstant: 112),
            freelancerImageView.widthAnchor.constraint(equalToConstant: 112),
            companyImageView.heightAnchor.constraint(equalToConstant: 112),
            companyImageView.widthAnchor.constraint(equalToConstant: 112),
            
            companyButton.heightAnchor.constraint(equalToConstant: 132),
            companyButton.widthAnchor.constraint(equalToConstant: 361),
            
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            freelaStack.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 26),
            freelaStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            freelaStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            companyStack.topAnchor.constraint(equalTo: freelaStack.bottomAnchor, constant: 12),
            companyStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companyStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
