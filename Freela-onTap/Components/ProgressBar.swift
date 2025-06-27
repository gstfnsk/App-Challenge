//
//  ProgressBar.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 24/06/25.
//

import UIKit
import SwiftUI

class ProgressBar: UIView {
    enum progressBarState {
        case first
        case second
        case last
    }
    
    lazy var firstBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor.DesignSystem.terracota0
        return bar
    }()
    
    lazy var secondBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor.DesignSystem.terracota0
        return bar
    }()
    
    lazy var lastBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor.DesignSystem.terracota0
        return bar
    }()

    lazy var barContainer: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [firstBar, secondBar, lastBar])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.backgroundColor = UIColor.DesignSystem.terracota600
        return stack
    }()
    

    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: public
    var currentState = progressBarState.first {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateState() {
            let activeColor = UIColor.DesignSystem.terracota400
            let inactiveColor = UIColor.DesignSystem.terracota0

            switch currentState {
            case .first:
                firstBar.backgroundColor = activeColor
                secondBar.backgroundColor = inactiveColor
                lastBar.backgroundColor = inactiveColor
            case .second:
                firstBar.backgroundColor = activeColor
                secondBar.backgroundColor = activeColor
                lastBar.backgroundColor = inactiveColor
            case .last:
                firstBar.backgroundColor = activeColor
                secondBar.backgroundColor = activeColor
                lastBar.backgroundColor = activeColor
            }
        }
}

extension ProgressBar: ViewCodeProtocol {
    func addSubviews() {
        addSubview(barContainer)
        updateState()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            barContainer.heightAnchor.constraint(equalToConstant: 4),
            barContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            barContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            barContainer.topAnchor.constraint(equalTo: topAnchor)
        ])
        updateState()
    }
}
//
//#Preview {
//    let progressBar = ProgressBar()
//    return progressBar
//}
