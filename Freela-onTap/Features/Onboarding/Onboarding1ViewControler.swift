//
//  Onboarding1ViewControler.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 18/06/25.
//

import UIKit
import Lottie
class OnboardingViewController: UIViewController {
    let animationView = LottieAnimationView(name: "Flow 3")
    
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
        imageView.contentMode = .scaleAspectFit
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
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        setup()
    }
    
    @objc func continueAction() {
        let onboarding2VC = Onboarding2ViewController()
        self.navigationItem.backButtonTitle = "Voltar"
        self.navigationController?.pushViewController(onboarding2VC, animated: true)
    }
}
extension OnboardingViewController: ViewCodeProtocol{
    func addSubviews() {
        view.addSubview(animationView)
        view.addSubview(logo)
        view.addSubview(nameImage)
        view.addSubview(descriptionImage)
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            animationView.heightAnchor.constraint(equalToConstant: 400),
            
            logo.bottomAnchor.constraint(equalTo: nameImage.topAnchor, constant: -102),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 98),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -113),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            nameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 330),
            nameImage.heightAnchor.constraint(equalToConstant: 93),
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
