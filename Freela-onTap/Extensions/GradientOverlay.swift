//
//  GradientOverlay.swift
//  Freela-onTap
//
//  Created by Giulia Stefainski on 20/06/25.
//

import UIKit

final class GradientOverlayView: UIView {
    private let gradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupGradient()
    }

    private func setupGradient() {
        gradient.colors = [
            UIColor.systemGray6.withAlphaComponent(0.3).cgColor,
            UIColor.systemGray6.withAlphaComponent(0.65).cgColor,
            UIColor.systemGray6.withAlphaComponent(1).cgColor
        ]
        //        gradient.
        //        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        //        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        layer.addSublayer(gradient)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradient.frame = bounds
    }
}
