//
//  FormOTPStackView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 06/12/2023.
//

import UIKit
import Combine

protocol FormOTPStackViewDelegate: AnyObject {
    func onOTPCodeUpdated()
}

final class FormOTPStackView: UIStackView, FormFieldEditable {

    // MARK: - Properties

    weak var delegate: FormOTPStackViewDelegate?

    var isAllDigitsAreEntered: Bool { otpCode.count == digitsCount }

    private var digitsCount: Int { arrangedSubviews.count }
    private let enteredCodeSubject: CurrentValueSubject<String, Never> = .init("")

    var otpCode: String {
        self.arrangedSubviews
            .map { ($0 as? FormOTPField)?.text ?? "" }
            .reduce("",  { $0 + $1 })
    }

    // MARK: - LifeCycle

    convenience init(noOfFields: Int) {
        let otpFields = (1...noOfFields).map { _ in FormOTPField() }
        self.init(arrangedSubviews: otpFields)

        setup()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            self.arrangedSubviews.forEach { _ = $0.resignFirstResponder() }
        }

        return super.resignFirstResponder()
    }

    // MARK: - Actions

    func doApplyErrorLayout() {
        //
    }

    func doClearErrorLayout() {
        //
    }

    // MARK: - View Setup

    private func setup() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = .dynamicToWidth(11)

        setupFields()

//        let firstField = self.arrangedSubviews[0]
//        _ = firstField.becomeFirstResponder()
    }

    private func setupFields() {
        for i in 0..<digitsCount {

            guard let field = self.arrangedSubviews[i] as? FormOTPField else { continue }

            // last digit
            if i == digitsCount-1 {
                field.onOTPInserted = { [weak self] in
                    guard let self = self else { return }

                    self.onOTPCodeUpdated()
                }

            // any digit except first
            } else {
                field.onOTPInserted = { [weak self] in
                    guard let self = self else { return }

                    let nextField = self.arrangedSubviews[i+1] as! FormOTPField
                    _ = nextField.becomeFirstResponder()

                    self.onOTPCodeUpdated()
                }
            }

            // handle when backspace tapped for empty text
            if i != 0 {
                field.onBackspaceTappedOnEmptyText = { [weak self] in
                    guard let self = self else { return }

                    let previousField = self.arrangedSubviews[i-1] as! FormOTPField
                    previousField.text = ""
                    _ = previousField.becomeFirstResponder()

                    self.onOTPCodeUpdated()
                }
            }

            // handle when backspace tapped for non-empty text
            field.onBackspaceTappedOnNonEmptyText = { [weak self] in
                guard let self = self else { return }

                self.onOTPCodeUpdated()
            }
        }
    }

    // MARK: - Helpers

    private func onOTPCodeUpdated() {
        self.delegate?.onOTPCodeUpdated()
        self.enteredCodeSubject.send(otpCode)
    }
}
