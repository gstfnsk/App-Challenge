//
//  Onboarding1ViewControler.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 18/06/25.
//

import UIKit
class OnboardingViewController: UIViewController {
    lazy var circle: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .DesignSystem.terracota600
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var logo: UIImageView = {
        var imageView = UIImageView()
        imageView.image = .sino
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var nameImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = .freela
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = .conectando
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Explorar o app", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [descriptionImage, continueButton])
        stackView.axis = .vertical
        stackView.spacing = 81
        stackView.alignment = .center
        stackView.layer.cornerRadius = 28
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @objc func continueAction() {
        let onBoardViewController = UINavigationController(rootViewController: JobListViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(onBoardViewController)
    }
}
extension OnboardingViewController: ViewCodeProtocol{
    func addSubviews() {
        view.addSubview(circle)
        view.addSubview(logo)
        view.addSubview(nameImage)
        view.addSubview(descriptionImage)
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            circle.bottomAnchor.constraint(equalTo: nameImage.topAnchor, constant: -28),
            circle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            circle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69),
            circle.heightAnchor.constraint(equalToConstant: 264),
            
            logo.bottomAnchor.constraint(equalTo: nameImage.topAnchor, constant: -102),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 98),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -113),
            logo.heightAnchor.constraint(equalToConstant: 137),
            
            nameImage.bottomAnchor.constraint(equalTo: descriptionImage.topAnchor, constant: -66),
            nameImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            nameImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -113),
            
            descriptionImage.widthAnchor.constraint(equalToConstant: 353),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.widthAnchor.constraint(equalToConstant: 361),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 480),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .DesignSystem.terracota0
    }
}
