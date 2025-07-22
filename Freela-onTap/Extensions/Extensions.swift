//
//  Extensions.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.
//

import UIKit

typealias Size = NSCollectionLayoutSize
typealias Item = NSCollectionLayoutItem
typealias Group = NSCollectionLayoutGroup
typealias Section = NSCollectionLayoutSection
typealias Layout = UICollectionViewCompositionalLayout
typealias Edges = NSDirectionalEdgeInsets
typealias Config = UICollectionViewCompositionalLayoutConfiguration

extension UISearchController {
    static func create(localizedPlaceholder placeholder: String = "Search") -> UISearchController {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        return searchController
    }
}


// MARK: - Get Enum Case Name (String)
extension RawRepresentable where Self: CaseIterable {
    var caseName: String {
        String(describing: self)
    }
}

// MARK: - Create Enum Case from Case Name String
extension CaseIterable where Self: RawRepresentable {
    static func fromCaseName(_ caseName: String) -> Self? {
        allCases.first { String(describing: $0) == caseName }
    }
}

// MARK: - timeAgoString

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    private init() {}
    
    let relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.unitsStyle = .abbreviated
        return formatter
    }()
    
    let dateFormatter = DateFormatter()
}

extension Date {
    func timeAgoString() -> String {
        let now = Date()
        return DateFormatterHelper.shared.relativeDateFormatter.localizedString(for: self, relativeTo: now)
    }
    
    func formatted(_ stringFormat: String) -> String {
        DateFormatterHelper.shared.dateFormatter.dateFormat = stringFormat
        return DateFormatterHelper.shared.dateFormatter.string(from: self)
    }
}

// MARK: - Image Resize + Base64
extension UIImage {
    /// Resize image to target size while maintaining aspect ratio.
    func resized(to targetSize: CGSize) -> UIImage? {
        let aspectWidth = targetSize.width / size.width
        let aspectHeight = targetSize.height / size.height
        let scaleFactor = min(aspectWidth, aspectHeight)

        let newSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }

    /// Returns a base64-encoded JPEG string after optional resizing.
    func base64(resizedTo targetSize: CGSize? = nil, compressionQuality: CGFloat = 1.0) -> String? {
        let imageToEncode = targetSize != nil ? self.resized(to: targetSize!) ?? self : self
        return imageToEncode.jpegData(compressionQuality: compressionQuality)?
            .base64EncodedString()
    }

    /// Initializes a UIImage from base64 string
    convenience init?(fromBase64 base64String: String) {
        guard let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        self.init(data: imageData)
    }
}
