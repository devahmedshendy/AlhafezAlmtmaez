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

    override func makeFormField() -> FormFieldEditable {
        FormTextField()
    }

    // MARK: - Actions

    private func setupActions() {
        textField.onBecomeFirstResponder = { [weak self] in
            _ = self?.titleLabel.becomeFirstResponder()
            _ = self?.errorLabel.becomeFirstResponder()
        }

        textField.onResignFirstResponder = { [weak self] in
            guard let self = self, self.text.isEmpty
            else { return }

            _ = self.titleLabel.resignFirstResponder()
            _ = self.errorLabel.resignFirstResponder()
        }
    }

    // MARK: - View Setup

    private func setupStrings() {
        
    }

    private func setupDynamicLayout() {

    }

    private func setupTitleLabel() {
        
        // Constraint Setup
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor
            ),
            titleLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor
            )
        ])
    }

    private func setupTextField() {
        
        // Constraints Setup
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(
                equalTo: self.leftAnchor
            ),
            textField.rightAnchor.constraint(
                equalTo: self.rightAnchor
            ),
            textField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: .dynamicToWidth(16)
            ),
            textField.bottomAnchor.constraint(
                equalTo: errorLabel.topAnchor
            )
        ])
    }

    private func setupErrorLabel() {

        // Constraints Setup
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor
            ),
            errorLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor
            ),
            errorLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
        ])
    }
}
