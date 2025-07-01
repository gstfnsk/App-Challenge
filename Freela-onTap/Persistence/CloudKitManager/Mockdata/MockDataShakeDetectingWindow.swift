//
//  UIWindow+ShakeGesture.swift
//  App-Challenge
//
//  Created by Gemini on 26/06/25.
//

import UIKit

// A private subclass that handles the standard shake gesture.
// It is only used by our extension below.
private class MockDataShakeDetectingWindow: UIWindow {
    // The action to perform when a shake is detected.
    var onShake: (() -> Void)?

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if DEBUG
        if motion == .motionShake {
            print("🤫 Gesto de shake padrão detectado!")
            onShake?()
        }
        #endif
        super.motionEnded(motion, with: event)
    }
}


extension UIWindow {
    /// Activates the standard system "shake" gesture for this window.
    /// When activated (in DEBUG mode), chacoalhar o dispositivo
    /// apresentará a tela de substituição de dados mocados.
    ///
    /// Exemplo de uso no SceneDelegate:
    /// ```
    /// #if DEBUG
    /// window.activateShakeGestureForMockdataReplacement()
    /// #endif
    /// ```
    func activateShakeGestureForMockdataReplacement() {
        #if DEBUG
        // This is a check to ensure we are using this on the main app window
        // and that a scene is attached.
        guard let windowScene = self.windowScene else {
            return
        }

        // To properly capture the shake gesture, we replace the default window
        // with our private subclass that can override `motionEnded`.
        // We do this here so the SceneDelegate remains clean.
        
        let shakeWindow = MockDataShakeDetectingWindow(windowScene: windowScene)
        
        // The action to be performed is to present our dev screen.
        shakeWindow.onShake = { [weak shakeWindow] in
            presentMockDataScreen(from: shakeWindow)
        }
        
        // Transfer the root view controller and make the new window visible.
        shakeWindow.rootViewController = self.rootViewController
        
        // In a Scene-based app, the scene retains the window.
        // We get the SceneDelegate to hold our new shakeWindow.
        (windowScene.delegate as? SceneDelegate)?.window = shakeWindow
        shakeWindow.makeKeyAndVisible()
        #endif
    }
}


// MARK: - Private Helper Functions

private func presentMockDataScreen(from window: UIWindow?) {
    guard let rootVC = window?.rootViewController, rootVC.presentedViewController == nil else {
        return
    }

    print("Apresentando a tela de dados mocados...")

    let mockDataVC = MockDataViewController()
    let navController = UINavigationController(rootViewController: mockDataVC)

    let closeButton = UIBarButtonItem(title: "Fechar", style: .done, target: navController, action: #selector(UINavigationController.dismissModal))
    mockDataVC.navigationItem.leftBarButtonItem = closeButton

    rootVC.present(navController, animated: true, completion: nil)
}

// Helper to dismiss the presented navigation controller.
extension UINavigationController {
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
