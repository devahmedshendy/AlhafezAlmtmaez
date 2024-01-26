//
//  FormTextFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

class FormTextFieldView: FormFieldView {

    // MARK: - Properties

    var text: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }

    private var textField: FormTextField { formField as! FormTextField }

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        setupActions()
    }

    override func makeFormField() -> FormFieldEditable {
        FormTextField()
    }

    // MARK: - Actions

    private func setupActions() {
        textField.onDidBecomeFirstResponder = { [weak self] in
            _ = self?.titleLabel.becomeFirstResponder()
            _ = self?.errorLabel.becomeFirstResponder()
        }

        textField.onDidResignFirstResponder = { [weak self] in
            _ = self?.titleLabel.resignFirstResponder()
            _ = self?.errorLabel.resignFirstResponder()
        }
    }
}
