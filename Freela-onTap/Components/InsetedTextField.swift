//
//  InsetedTextField.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 23/06/25.
//


import UIKit

class InsetedTextField: UITextField {
    var insetX: Double = 16
    var insetY: Double = 10

    init(insetX: Double, insetY: Double) {
        super.init(frame: .zero)

        self.insetX = insetX
        self.insetY = insetY
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: insetX, dy: insetY)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}
