//
//  MockdataHoldButton.swift
//  Freela-onTap
//
//  Created by Adriel de Souza on 21/06/25.
//


import UIKit

final class MockdataHoldButton: UIButton {
    private var holdTimer: Timer?
    private let holdDuration: TimeInterval = 7.0
    
    var onConfirmRestore: () -> Void = {}
    var parentViewController: UIViewController?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    // MARK: - Setup
    
    private func setupButton() {
        backgroundColor = .clear
        setTitle(" ", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    // MARK: - Touch Handlers
    
    @objc private func touchDown() {
        backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        holdTimer = Timer.scheduledTimer(timeInterval: holdDuration, target: self, selector: #selector(showConfirmationAlert), userInfo: nil, repeats: false)
    }
    
    @objc private func touchUp() {
        backgroundColor = .clear
        holdTimer?.invalidate()
        holdTimer = nil
    }
    
    // MARK: - Alert
    
    @objc private func showConfirmationAlert() {
        backgroundColor = .clear
        holdTimer = nil
        
        let alert = UIAlertController(
            title: "Restore Mock Data",
            message: "Do you want to restore the mock data?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Restore", style: .default) { _ in
            self.onConfirmRestore()
        })
        
        parentViewController?.present(alert, animated: true)
    }
}
