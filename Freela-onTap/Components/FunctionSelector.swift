//
//  FunctionSelector.swift
//  Freela-onTap
//
//  Created by Ana Carolina Palhares Poletto on 24/06/25.
//
import UIKit

class FunctionSelector: UIView {
    lazy var button: UIButton = {
        var button = UIButton()
        var configuration = UIButton.Configuration.plain()
        let attributedTitle = AttributedString("Selecionar", attributes: AttributeContainer([
            .foregroundColor: UIColor.labelsSecondary,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        )


        configuration.attributedTitle = attributedTitle
        button.configuration = configuration
        button.menu = UIMenu(title: "", options: [.singleSelection], children: functionSelector)
        button.showsMenuAsPrimaryAction = true
        return button
    }()

    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [button])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.layer.cornerRadius = 12
        stack.backgroundColor = .tertiarySystemBackground
        button.contentHorizontalAlignment = .right
        return stack
    }()

    // MARK: Properties
    private var functionSelector: [UIAction] {
        return JobPosition.allCases.sorted { $0.rawValue < $1.rawValue }
            .map { function in
                UIAction(
                    title: function.rawValue.capitalized,
                    image: UIImage(systemName: function.iconName)
                )                    { [weak self] _ in
                        self?.selectedFunction = function
                        self?.onSelectionChanged?()
                    }
            }
    }

    var onSelectionChanged: (() -> Void)?

    var selectedFunction: JobPosition? {
        didSet {
            var config = button.configuration
            let title = selectedFunction?.rawValue.capitalized ?? "Selecionar"

            let attributedTitle = AttributedString(title, attributes: AttributeContainer([
                .foregroundColor: UIColor.DesignSystem.terracota600, // nova cor após seleção
                .font: UIFont.systemFont(ofSize: 16)
            ]))

            config?.attributedTitle = attributedTitle
            button.configuration = config
        }
    }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FunctionSelector: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
