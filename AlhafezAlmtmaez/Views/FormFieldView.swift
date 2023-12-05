//
//  FormFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

@objc class FormFieldView: UIView {

    // MARK: - Properties

    var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    var value: String {
        textField.text ?? ""
    }

    var error: String {
        get {
            errorLabel.text ?? ""
        }
        set {
            errorLabel.text = newValue
            textField.hasError = newValue.isEmpty == false
        }
    }

    // MARK: - Subviews

    private lazy var titleLabel: FormFieldTitleLabel = .init()
    private lazy var textField: FormTextField = makeTextField()
    private lazy var errorLabel: FormFieldErrorLabel = .init()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    func setup() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)

        setupStrings()
        setupDynamicLayout()

        setupTitleLabel()
        setupTextField()
        setupErrorLabel()

        setupActions()
    }

    func makeTextField() -> FormTextField {
        return .init()
    }

    // MARK: - Actions

    private func setupActions() {
        textField.onBecomeFirstResponder = { [weak self] in
            _ = self?.titleLabel.becomeFirstResponder()
            _ = self?.errorLabel.becomeFirstResponder()
        }

        textField.onResignFirstResponder = { [weak self] in
            guard let self = self, self.value.isEmpty
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
