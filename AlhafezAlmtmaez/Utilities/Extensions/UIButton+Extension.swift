//
//  UIButton+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIButton {
    func createUnderlineAttributedString(
        _ text: String,
        font: UIFont
    ) -> AttributedString {
        .init(
            text,
            attributes: AttributeContainer([
                .font: font,
                .underlineStyle: NSUnderlineStyle.single,
            ])
        )
    }
}
