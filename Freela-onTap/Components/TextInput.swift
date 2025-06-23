//
//  TextInput.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 23/06/25.
//


import UIKit

final class TextInput: UIView {
    // MARK: - Public Properties
    // Add public properties here to configure the component
    enum TextInputState {
        case normal
        case error
        case disabled
    }
    
    var state = TextInputState.normal {
        didSet {
            changeState(state)
        }
    }
    
    var labelText = "Input" {
        didSet {
            // TODO
        }
    }
    
    var placeholderText = "Input name" {
        didSet {
            // TODO
        }
    }
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }

    // MARK: - Private Methods
    private func changeState(_ state: TextInputState) {
        switch state {
        case .normal:
            label.textColor = .secondaryLabel
            textField.layer.borderWidth = 0
        case .error:
            label.textColor = .secondaryLabel
            textField.layer.borderWidth = 1
        case .disabled:
            label.textColor = .quaternaryLabel
            textField.layer.borderWidth = 0
        }
        
        textField.isEnabled = state != .disabled
    }

    // MARK: - UI Elements
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = .DesignSystem.subheadline
        label.textColor = .secondaryLabel
        label.text = labelText
        
        return label
    }()
    
    private lazy var textField: InsetedTextField = {
        let textField = InsetedTextField(insetX: 16, insetY: 10)
                
        textField.font = .DesignSystem.body
        textField.textColor = .label
        textField.placeholder = placeholderText
        textField.layer.borderColor = UIColor.DesignSystem.terracota700.cgColor
        textField.backgroundColor = .tertiarySystemBackground
        
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
                
        return textField
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 10
                
        return stackView
    }()
}

extension TextInput: ViewCodeProtocol {
    // MARK: - Add Subviews
    func addSubviews() {
        addSubview(inputStackView)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: topAnchor),
            inputStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    // MARK: - Additional Configuration
    func setupAdditionalConfiguration() {
        changeState(state)
    }
}



#Preview {
    var normalTextInput = TextInput()

    var errorTextInput = TextInput()
    errorTextInput.state = .error
    
    var filledTextInput = TextInput()
    filledTextInput.text = "Some text"
    
    var disabledTextInput = TextInput()
    disabledTextInput.state = .disabled
    
    var stacked: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [normalTextInput, errorTextInput, filledTextInput, disabledTextInput])
        stack.axis = .vertical
        stack.spacing = 16
        
        return stack
    }()
    
    stacked.widthAnchor.constraint(equalToConstant: 300).isActive = true
    return stacked
}
