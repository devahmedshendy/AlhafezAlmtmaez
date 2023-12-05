//
//  UIFont+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIFont {
    
    // MARK: - AvenirArabic

    static func avenirArabic_500(size: CGFloat, dynamic: Bool = true) -> UIFont {
        .init(
            name: "AvenirArabic-Medium",
            size: dynamic ? .dynamicToWidth(size) : size
        )!
    }

    static func avenirArabic_800(size: CGFloat, dynamic: Bool = true) -> UIFont {
        .init(
            name: "AvenirArabic-Heavy",
            size: dynamic ? .dynamicToWidth(size) : size
        )!
    }

    // MARK: - Custom

    static var formNormalTextField: UIFont {
        avenirArabic_500(size: 16)
    }
    static var formFocusedTextField: UIFont {
        avenirArabic_800(size: 16)
    }
    static var formSubmitButton: UIFont {
        avenirArabic_800(size: 16)
    }
}
