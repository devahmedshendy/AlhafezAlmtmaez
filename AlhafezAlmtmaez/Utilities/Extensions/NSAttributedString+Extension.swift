//
//  NSAttributedString+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension NSAttributedString {
    static func attributes(
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        lineHeight: CGFloat? = nil,
        underlineColor: UIColor = .clear,
        underlineStyle: NSUnderlineStyle = .single
    ) -> [NSAttributedString.Key : Any] {
        var attributes: [NSAttributedString.Key : Any] = [:]

        attributes[.font] = font
        attributes[.foregroundColor] = textColor

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment

        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }

        attributes[.paragraphStyle] = paragraphStyle

        if underlineColor != .clear {
            attributes[.underlineColor] = underlineColor
            attributes[.underlineStyle] = underlineStyle.rawValue
        }

        return attributes
    }

    static func formLabelAttributedString(
        _ text: String?,
        font: UIFont
    ) -> NSAttributedString? {
        guard let text = text else { return nil }

        let attributedString = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.minimumLineHeight = font.pointSize * 2
        paragraphStyle.maximumLineHeight = font.pointSize * 2

        attributedString.addAttributes(
            [
                NSAttributedString.Key.font : font,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ],
            range: .init(location: 0, length: text.count)
        )

        return attributedString
    }
}
