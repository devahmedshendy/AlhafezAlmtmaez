//
//  String+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    func ignoreLocalization() -> String {
        "\u{202A}" + self + "\u{202C}"
    }
}
