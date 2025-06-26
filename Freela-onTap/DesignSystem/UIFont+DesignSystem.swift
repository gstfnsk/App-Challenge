//
//  UIFont+DesignSystem.swift
//  App-Challenge
//
//  Defines the app-wide design system fonts with Dynamic Type support.
//

import UIKit

extension UIFont {
    struct DesignSystem {
        // MARK: - System Text Styles (Dynamic Type)

        static let largeTitle = UIFont.dynamic(.largeTitle, weight: .regular)
        static let textStyles = UIFont.dynamic(.largeTitle, weight: .bold)
        static let title1 = UIFont.dynamic(.title1, weight: .regular)
        static let title2 = UIFont.dynamic(.title2, weight: .regular)
        static let title2Emphasized = UIFont.dynamic(.title2, weight: .bold)
        static let title3 = UIFont.dynamic(.title3, weight: .regular)
        static let title3Emphasized = UIFont.dynamic(.title3, weight: .bold)
        static let title3SemiBold = UIFont.dynamic(.title3, weight: .semibold)
        static let body = UIFont.dynamic(.body, weight: .regular)
        static let bodyEmphasized = UIFont.dynamic(.body, weight: .bold)
        static let headline = UIFont.dynamic(.headline, weight: .semibold)
        static let callout = UIFont.dynamic(.callout, weight: .regular)
        static let subheadline = UIFont.dynamic(.subheadline, weight: .regular)
        static let footnote = UIFont.dynamic(.footnote, weight: .regular)
        static let caption1 = UIFont.dynamic(.caption1, weight: .regular)
        static let caption2 = UIFont.dynamic(.caption2, weight: .regular)

        // MARK: - Custom Font (Dynamic Type)

        static let styledHeader = UIFont.dynamicCustom(
            name: "PPValve-PlainMedium",
            size: 40,
            textStyle: .largeTitle
        )
    }

    /// Returns a system font scaled for Dynamic Type based on the provided text style and weight.
    private static func dynamic(_ textStyle: UIFont.TextStyle, weight: UIFont.Weight) -> UIFont {
        let baseSize = UIFont.defaultPointSize(for: textStyle)
        let baseFont = UIFont.systemFont(ofSize: baseSize, weight: weight)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: baseFont)
    }

    /// Returns a custom font scaled for Dynamic Type.
    private static func dynamicCustom(name: String, size: CGFloat, textStyle: UIFont.TextStyle) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            assertionFailure("Failed to load font: \(name)")
            return UIFont.systemFont(ofSize: size)
        }

        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }

    /// Returns the default unscaled point size used by Apple for the given text style.
    private static func defaultPointSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle:
            return 34
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline, .body:
            return 17
        case .callout:
            return 16
        case .subheadline:
            return 15
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            return 17
        }
    }
}

extension UILabel {
    func applyDynamicFont(_ font: UIFont) {
        self.font = font
        self.adjustsFontForContentSizeCategory = true
    }
}

extension UIButton {
    func applyDynamicFont(_ font: UIFont) {
        self.titleLabel?.font = font
        self.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}
