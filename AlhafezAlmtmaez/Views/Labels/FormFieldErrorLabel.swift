//
//  FormFieldErrorLabel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

final class FormFieldErrorLabel: FormFieldBaseLabel {
    override var _normalFont: UIFont { .avenirArabic_500(size: 14) }
    override var _focusedFont: UIFont { .avenirArabic_800(size: 14) }
    override var _textColor: UIColor { .formFieldError }

    override func setup() {
        super.setup()

        numberOfLines = 0
    }
}
