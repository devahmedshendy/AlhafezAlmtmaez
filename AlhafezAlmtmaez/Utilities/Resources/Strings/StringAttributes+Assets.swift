//
//  StringAttributes+Assets.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

// MARK: - AttributedString

extension AttributedString {
    static func formSubmitTitle(_ text: String) -> AttributedString {
        .init(
            text,
            attributes: .init(.formSubmitTitle)
        )
    }
}

// MARK: - Dictionary - [NSAttributedString.Key: Any]

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    static var navigationTitle: [NSAttributedString.Key : Any] {
        NSAttributedString.attributes(
            font: .avenirArabic_800(size: 16, dynamic: false),
            textColor: .navigationTitle,
            textAlignment: .center
        )
    }

    static var formSubmitTitle: [NSAttributedString.Key : Any] {
        NSAttributedString.attributes(
            font: .avenirArabic_800(size: 16),
            textColor: .white,
            textAlignment: .right
        )
    }
}
