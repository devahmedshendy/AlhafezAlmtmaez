//
//  FormTextField.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

class FormTextField: UITextField, FormFieldEditable {

    // MARK: - Theme

    var _textLength: Int? { nil }

    var _normalFont: UIFont { .formNormalTextField }
    var _focusedFont: UIFont { .formFocusedTextField }

    var _textColor: UIColor { .formFieldText }
    
    var _backgroundNormalColor: UIColor { .formFieldBackgroundNormal }
    var _backgroundFocusedColor: UIColor { _backgroundNormalColor }
    var _backgroundErrorColor: UIColor { .formFieldBackgroundError }

    var _borderNormalColor: UIColor { .formFieldBorder }
    var _borderFocusedColor: UIColor { _borderNormalColor }
    var _borderErrorColor: UIColor { .formFieldError }
    
    var _placeholderColor: UIColor {
        .formFieldPlaceholder.withAlphaComponent(0.5)
    }

    var _unfocusedIconColor: UIColor { .formFieldIcon.withAlphaComponent(0.5) }
    var _focusedIconColor: UIColor { .formFieldIcon }

    var _cornerRadius: CGFloat { .formCornerRadius }

    var _contentRightInset: CGFloat { .dynamicToWidth(18) }
    var _contentLeftInset: CGFloat { .dynamicToWidth(15) }
    var _contentTopInset: CGFloat { .dynamicToWidth(14) }
    var _contentBottomInset: CGFloat { .dynamicToWidth(14) }

    private var _contentInsets: UIEdgeInsets {
        let leftInset: CGFloat = (
            leftView == nil
            ? 0
            : .dynamicToWidth(30)
        ) + _contentLeftInset

        let rightInset: CGFloat = (
            rightView == nil 
            ? 0
            : .dynamicToWidth(30)
        ) + _contentRightInset

        return UIEdgeInsets(
            top: _contentTopInset,
            left: leftInset,
            bottom: _contentBottomInset,
            right: rightInset
        )
    }

    // MARK: - Properties

    var onDidBecomeFirstResponder: (() -> Void)?
    var onDidResignFirstResponder: (() -> Void)?

    var leftImage: UIImage? { nil }
    var rightImage: UIImage? { nil }
    var shouldMoveCursorToEndOnBecomeFirstResponder: Bool { true }
    var shouldKeepPlaceholderPrefixOnResignFirstResponder: Bool { false }

    override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }

            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor : _placeholderColor]
            )
        }
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = _backgroundNormalColor
            layer.backgroundColor = _backgroundNormalColor.cgColor
        }
    }

    // MARK: - Subviews

    var leftImageView: UIImageView? {
        self.leftView?.subviews.first as? UIImageView
    }

    var rightImageView: UIImageView? {
        self.rightView?.subviews.first as? UIImageView
    }

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
        font = _normalFont
        tintColor = .clear
        textColor = _textColor
        backgroundColor = _backgroundNormalColor

        borderStyle = .none
        autocapitalizationType = .none
//        semanticContentAttribute = .forceRightToLeft
        textAlignment = .right

        layer.borderColor = _borderNormalColor.cgColor
        layer.borderWidth = .dynamicToWidth(1)
        layer.cornerRadius = _cornerRadius

        setupActions()
    }

    // MARK: - Actions

    private func setupActions() {
        addTarget(
            self,
            action: #selector(onEditingChanged),
            for: .editingChanged
        )
    }

    @objc private func onEditingChanged() {
        guard
            let textLength = _textLength,
            let clippedText = text?.prefix(textLength)
        else { return }

        text = String(describing: clippedText)
    }

    func onDeferBecomeFirstResponder() {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async {
                self.onDeferBecomeFirstResponder()
            }
        }

        doApplyFocusedLayout()

        onDidBecomeFirstResponder?()
    }

    func onDeferResignFirstResponder() {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async {
                self.onDeferResignFirstResponder()
            }
        }

        doApplyNormalLayout()

        onDidResignFirstResponder?()
    }

    func doApplyNormalLayout() {
        self.font = self._normalFont
        self.backgroundColor = self._backgroundNormalColor
        self.layer.borderColor = self._borderNormalColor.cgColor
    }

    func doApplyFocusedLayout() {
        self.font = self._focusedFont
        self.backgroundColor = self._backgroundFocusedColor
        self.layer.borderColor = self._borderFocusedColor.cgColor
    }

    func doApplyErrorLayout() {
        layer.borderColor = _borderErrorColor.cgColor
        backgroundColor = _backgroundErrorColor
    }

    func doClearErrorLayout() {
        layer.borderColor = _borderNormalColor.cgColor
        backgroundColor = _backgroundNormalColor
    }

    // MARK: - Responders

    override func becomeFirstResponder() -> Bool {
        defer {
            self.onDeferBecomeFirstResponder()
        }

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            self.onDeferResignFirstResponder()
        }

        return super.resignFirstResponder()
    }

    // MARK: - Field Insets

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _contentInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _contentInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _contentInsets)
    }
}
