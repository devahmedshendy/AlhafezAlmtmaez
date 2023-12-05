//
//  UIImage+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIImage {
    static var formSubmitFieldIcon: UIImage {
        .init(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration.init(
                pointSize: .dynamicToWidth(12),
                weight: .bold
            )
        )!
    }
}
