//
//  PhoneNumberFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

final class PhoneNumberFieldView: FormTextFieldView {

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        title = .text.phoneNumber
    }

    override func makeFormField() -> FormFieldEditable {
        PhoneNumberField()
    }
}
