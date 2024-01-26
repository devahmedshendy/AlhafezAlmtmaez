//
//  PhoneNumberField.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import Foundation

final class PhoneNumberField: FormTextField {

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        keyboardType = .phonePad
        textContentType = .telephoneNumber
    }
}
