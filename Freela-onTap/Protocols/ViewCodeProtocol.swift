//
//  ViewCodeProtocol.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 09/06/25.
//

protocol ViewCodeProtocol {
    func setup()
    func addSubviews()
    func setupConstraints()
    func setupAdditionalConfiguration()
}


extension ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
        setupAdditionalConfiguration()
    }

    func setupAdditionalConfiguration(){}
}
