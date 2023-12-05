//
//  PhoneNumberFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

final class PhoneNumberFieldView: FormFieldView {

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        title = .text.phoneNumber
    }

    override func makeTextField() -> FormTextField {
        PhoneNumberField()
    }
}
