//
//  LoginViewController.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 17/06/25.
//

import AuthenticationServices
import UIKit

class LoginViewController: UIViewController {
    lazy var appleButton: ASAuthorizationAppleIDButton = {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false

        appleButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        return appleButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @objc func handleAppleIdRequest() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        // What will be requested to the user
        request.requestedScopes = [/*.fullName, .email*/]
        
        // Authorization modal
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }

        let userId = credential.user
        print("Sign in! userId: \(userId)")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error here
        print("Sign in with Apple failed: \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}


extension LoginViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(appleButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appleButton.heightAnchor.constraint(equalToConstant: 44),
            appleButton.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
}
