//
//  BigTextField.swift
//  Freela-onTap
//
//  Created by Ana Carolina Palhares Poletto on 25/06/25.
//
import UIKit

class BigTextField: UIView {
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Atribuições, requisitos e detalhes da vaga: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = "Atendimento ao público, anotar pedidos, servir alimentos e bebidas, organizar mesas, apoiar na limpeza e organização do salão e repor itens quando necessário."
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var text: String? {
        didSet {
            descriptionLabel.text = text
        }
    }
    var placeholder: String? {
        didSet {
            descriptionTextField.text = placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        descriptionTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BigTextField: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
}
extension BigTextField: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .secondaryLabel
        }
    }
}
