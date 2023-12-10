//
//  FormOTPField.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 06/12/2023.
//

import UIKit

final class FormOTPField: FormTextField {

    // MARK: - Constants

    override var _normalFont: UIFont { _focusedFont }

    override var _textColor: UIColor { .formOTPFieldText }

    override var _backgroundNormalColor: UIColor { .formOTPFieldBackgroundNormal.withAlphaComponent(0.45) }
    override var _backgroundFocusedColor: UIColor { .formOTPFieldBackgroundNormal }
    
    override var _borderNormalColor: UIColor { .formOTPFieldBorder.withAlphaComponent(0.51) }
    override var _borderFocusedColor: UIColor { .formOTPFieldBorder }

    override var _cornerRadius: CGFloat { .dynamicToWidth(4) }

    override var _contentLeftInset: CGFloat { .dynamicToWidth(20) }
    override var _contentRightInset: CGFloat { .dynamicToWidth(20) }
    override var _contentTopInset: CGFloat { .dynamicToWidth(18) }
    override var _contentBottomInset: CGFloat { .dynamicToWidth(18) }

    // MARK: - Properties

    var onOTPInserted: (() -> Void)?
    var onBackspaceTappedOnEmptyText: (() -> Void)?
    var onBackspaceTappedOnNonEmptyText: (() -> Void)?

    // MARK: - LifeCycle

    override func deleteBackward() {
        if text?.isEmpty ?? true {
            onBackspaceTappedOnEmptyText?()
            return
        }

        super.deleteBackward()
    }

    // MARK: - View Setup

    override func setup() {
        super.setup()

        keyboardType = .numberPad
        autocapitalizationType = .none
        autocorrectionType = .no
        textAlignment = .center

        delegate = self

        setupActions()
    }

    @objc private func moveCursorToTheEnd() {
        DispatchQueue.main.async { [unowned self] in
            self.selectedTextRange = self.textRange(
                from: self.endOfDocument,
                to: self.endOfDocument
            )
        }
    }

    // MARK: - Actions

    private func setupActions() {
        addTarget(
            self,
            action: #selector(moveCursorToTheEnd),
            for: .allEditingEvents
        )
    }
}

// MARK: - UITextFieldDelegate

extension FormOTPField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.text = string

        if string.count > 0 {
            onOTPInserted?()
        } else {
            onBackspaceTappedOnNonEmptyText?()
        }

        return false
    }
}
