//
//  Template.swift
//  App-Challenge
//
//  Created by Adriel de Souza on 09/06/25.
//

import UIKit

final class UIComponentName: UIView {
    
    // MARK: - Public Properties
    // Add public properties here to configure the component
    
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

    // MARK: - UI Elements
    // Declare your UI elements here (e.g., labels, images, buttons)
}

extension UIComponentName: ViewCodeProtocol {
    
    // MARK: - Add Subviews
    
    func addSubviews() {
        // Add your subviews to the view hierarchy here
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        // Define and activate layout constraints here
    }
    
    // MARK: - Additional Configuration
    
    func setupAdditionalConfiguration() {
        // Additional setup like backgroundColor, layer, etc.
        backgroundColor = .clear
    }
}
