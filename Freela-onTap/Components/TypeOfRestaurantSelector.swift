//
//  TypeOfRestaurantSelector.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 25/06/25.
//

//
//  SizeSelector.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 25/06/25.
//

import UIKit
import SwiftUI

class TypeOfRestaurantSelector: UIView {
    lazy var button: UIButton = {
        var button = UIButton()
        var configuration = UIButton.Configuration.plain()
        let attributedTitle = AttributedString("Selecionar", attributes: AttributeContainer([
            .foregroundColor: UIColor.labelsSecondary,
            .font: UIFont.systemFont(ofSize: 16)
        ]))

        configuration.attributedTitle = attributedTitle
        button.configuration = configuration
        button.menu = UIMenu(title: "Selecione abaixo", options: [.singleSelection], children: functionSelector)
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

        return stack
    }()

    // MARK: Properties
    private var functionSelector: [UIAction] {
        return EstablishmentType.allCases.reversed().map { size in
            UIAction(title: size.rawValue) { [weak self] _ in
                self?.selectedFunction = size
            }
        }
    }

    var selectedFunction: EstablishmentType? {
        didSet {
            var config = button.configuration
            let title = selectedFunction?.rawValue ?? "Selecionar"

            let attributedTitle = AttributedString(title, attributes: AttributeContainer([
                .foregroundColor: UIColor.DesignSystem.terracota600,
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

extension TypeOfRestaurantSelector: ViewCodeProtocol {
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

#Preview {
    let test = TypeOfRestaurantSelector()
    return test
}
