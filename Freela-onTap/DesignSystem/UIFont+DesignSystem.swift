//
//  UIFont+DesignsystemFont.swift
//  App-Challenge
//
//

import UIKit

extension UIFont {
    /// Xcode's autocomplete allows for easy discovery of design systemFont UIFonts.
    /// At any call site that requires a UIFont, type `UIFont.DesignsystemFont.<esc>`
    struct DesignSystem {
        static let largeTitle = UIFont.systemFont(ofSize: 34, weight: .regular)
        static let textStyles = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let title1 = UIFont.systemFont(ofSize: 28, weight: .regular)
        static let title2 = UIFont.systemFont(ofSize: 22, weight: .regular)
        static let title2Emphasized = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let title3 = UIFont.systemFont(ofSize: 20, weight: .regular)
        static let title3Emphasized = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let bodyEmphasized = UIFont.systemFont(ofSize: 17, weight: .bold)
        static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let callout = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let subheadline = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let caption1 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let quaternaryLabelCol = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let tertiaryLabelColor = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let secondaryLabelColo = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let labelColor = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let caption2 = UIFont.systemFont(ofSize: 11, weight: .regular)
    }
}
