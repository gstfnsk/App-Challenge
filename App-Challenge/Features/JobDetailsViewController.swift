//
//  JobDetailsViewController.swift
//  App-Challenge
//
//  Created by Giulia Stefainski on 10/06/25.
//

import UIKit

class JobDetailsViewController: UIViewController {
    private lazy var jobDetailsTitle: UILabel = {
            var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Detalhes da Vaga"
            label.textAlignment = .center
            label.font = UIFont(name: "SFProRounded-Bold", size: 30)
            return label
        }()
    
    private lazy var contactButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Contatar empresa", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(openWhatsApp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    @objc private func openWhatsApp() {
        if let url = URL(string: "https://wa.me/+5551997645781?text=Oi%2C%20vi%20o%20an%C3%BAncio%20da%20vaga%20no%20%2AFreela%20onTap%2A%20e%20gostaria%20de%20me%20candidatar.") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension JobDetailsViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(contactButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: 200),
            contactButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
