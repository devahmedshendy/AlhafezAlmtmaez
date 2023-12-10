//
//  OTPFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 08/12/2023.
//

import Foundation

final class OTPFieldView: FormFieldView {

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        title = ""
    }

    override func makeFormField() -> FormFieldEditable {
        FormOTPStackView(noOfFields: 4)
    }
}
