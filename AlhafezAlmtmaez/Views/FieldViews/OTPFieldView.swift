//
//  OTPFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 08/12/2023.
//

import Foundation

final class OTPFieldView: FormFieldView {

    // MARK: - Properties

    var otpCode: String { stackView.otpCode }

    // MARK: - Subviews

    private var stackView: FormOTPStackView {
        formField as! FormOTPStackView
    }

    // MARK: - LifeCycle

    override func makeFormField() -> FormFieldEditable {
        FormOTPStackView(noOfFields: 4)
    }
}
