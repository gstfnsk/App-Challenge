//
//  UIFont+DesignsystemFont.swift
//  App-Challenge
//
//

import UIKit

extension UIFont {
    struct DesignSystem {
        // MARK: - Text Styles

        static let largeTitle = UIFont.dynamic(.largeTitle, weight: .regular)
        static let title1 = UIFont.dynamic(.title1, weight: .regular)
        static let title2 = UIFont.dynamic(.title2, weight: .regular)
        static let title2Emphasized = UIFont.dynamic(.title2, weight: .bold)
        static let title3 = UIFont.dynamic(.title3, weight: .regular)
        static let title3Emphasized = UIFont.dynamic(.title3, weight: .bold)
        static let body = UIFont.dynamic(.body, weight: .regular)
        static let bodyEmphasized = UIFont.dynamic(.body, weight: .bold)
        static let headline = UIFont.dynamic(.headline, weight: .semibold)
        static let callout = UIFont.dynamic(.callout, weight: .regular)
        static let subheadline = UIFont.dynamic(.subheadline, weight: .regular)
        static let footnote = UIFont.dynamic(.footnote, weight: .regular)
        static let caption1 = UIFont.dynamic(.caption1, weight: .regular)
        static let caption2 = UIFont.dynamic(.caption2, weight: .regular)
        
        // MARK: - Custom Fonts (Dynamic Type Supported)

        static let styledHeader = UIFont.dynamicCustom(
            name: "PPValve-PlainMedium",
            size: 40,
            textStyle: .largeTitle
        )
    }
    
    /// Returns a system font scaled for Dynamic Type based on the given text style and weight.
    private static func dynamic(_ textStyle: UIFont.TextStyle, weight: UIFont.Weight) -> UIFont {
        let baseSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let baseFont = UIFont.systemFont(ofSize: baseSize, weight: weight)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: baseFont)
    }
    
    /// Returns a scaled custom font that supports Dynamic Type, mapped to the provided text style.
    /// Falls back to system font if the custom font fails to load.
    private static func dynamicCustom(name: String, size: CGFloat, textStyle: UIFont.TextStyle) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            assertionFailure("Failed to load font: \(name)")
            return UIFont.systemFont(ofSize: size)
        }
        
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }
}

extension UILabel {
    /// Applies the given font and enables Dynamic Type scaling for this label.
    func applyDynamicFont(_ font: UIFont) {
        self.font = font
        self.adjustsFontForContentSizeCategory = true
    }
}
