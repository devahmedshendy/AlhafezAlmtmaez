//
//  FormFieldView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 08/12/2023.
//

import UIKit

protocol FormFieldEditable: UIView {
    func doApplyErrorLayout()
    func doClearErrorLayout()
}

class FormFieldView: UIView {

    // MARK: - Properties

    var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    var error: String? {
        didSet {
            guard let error = error else {
                doClearError()
                return
            }

            doSetError(error)
        }
    }

    // MARK: - Subviews

    private(set) lazy var titleLabel: FormFieldTitleLabel = .init()
    private(set) lazy var formField: FormFieldEditable = makeFormField()
    private(set) lazy var errorLabel: FormFieldErrorLabel = .init()

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
        addSubview(formField)
        addSubview(errorLabel)

        setupTitleLabel()
        setupFormField()
        setupErrorLabel()
    }

    func makeFormField() -> FormFieldEditable {
        return FormTextField()
    }

    // MARK: - Actions

    func doSetError(_ text: String) {
        guard text.isEmpty == false else {
            return doClearError()
        }
        errorLabel.text = text
        formField.doApplyErrorLayout()
    }

    func doClearError() {
        errorLabel.text = ""
        formField.doClearErrorLayout()
    }
}

// MARK: - View Setup

extension FormFieldView {
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

    private func setupFormField() {

        // Constraints Setup
        formField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            formField.leftAnchor.constraint(
                equalTo: self.leftAnchor
            ),
            formField.rightAnchor.constraint(
                equalTo: self.rightAnchor
            ),
            formField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: .dynamicToWidth(16)
            ),
            formField.bottomAnchor.constraint(
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
