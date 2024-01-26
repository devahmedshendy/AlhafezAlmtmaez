//
//  PhoneNumberFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

final class PhoneNumberFieldView: FormTextFieldView {
    override func setup() {
        super.setup()

        title = .text.PhoneNumber
    }

    override func makeFormField() -> FormFieldEditable {
        PhoneNumberField()
    }
}
