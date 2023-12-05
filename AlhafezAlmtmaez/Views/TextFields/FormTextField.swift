//
//  FormTextField.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

class FormTextField: UITextField {

    // MARK: - Theme

    var _textLength: Int? { nil }
    var _normalFont: UIFont { .formNormalTextField }
    var _focusedFont: UIFont { .formFocusedTextField }
    var _backgroundNormalColor: UIColor {
        isEnabled
        ? .formFieldBackgroundNormal
        : .init(red: 0.757, green: 0.686, blue: 0.682, alpha: 1.0)
    }
    var _backgroundErrorColor: UIColor {
        .formFieldBackgroundError
    }
    var _borderNormalColor: UIColor { .formFieldBorder }
    var _borderErrorColor: UIColor { .formFieldError }
    var _textColor: UIColor { .formFieldText }
    var _placeholderColor: UIColor {
        .formFieldPlaceholder.withAlphaComponent(0.5)
    }
    var _unfocusedIconColor: UIColor { .formFieldIcon.withAlphaComponent(0.5) }
    var _focusedIconColor: UIColor { .formFieldIcon }

    var _cornerRadius: CGFloat { .formCornerRadius }

    var _textRightInset: CGFloat { .dynamicToWidth(18) }
    var _textLeftInset: CGFloat { .dynamicToWidth(15) }
    var _textVerticalInset: CGFloat { .dynamicToWidth(14) }

    private var _textInsets: UIEdgeInsets {
        let leftInset: CGFloat = (
            leftView == nil
            ? 0
            : .dynamicToWidth(30)
        ) + _textLeftInset

        let rightInset: CGFloat = (
            rightView == nil 
            ? 0
            : .dynamicToWidth(30)
        ) + _textRightInset

        return UIEdgeInsets(
            top: _textVerticalInset,
            left: leftInset,
            bottom: _textVerticalInset,
            right: rightInset
        )
    }

    // MARK: - Properties

    var onBecomeFirstResponder: (() -> Void)?
    var onResignFirstResponder: (() -> Void)?

    var leftImage: UIImage? { nil }
    var rightImage: UIImage? { nil }
    var shouldMoveCursorToEndOnBecomeFirstResponder: Bool { true }
    var shouldKeepPlaceholderPrefixOnResignFirstResponder: Bool { false }

    var hasError: Bool = false {
        didSet {
            layer.borderColor = hasError 
            ? _borderErrorColor.cgColor
            : _borderNormalColor.cgColor
            backgroundColor = hasError
            ? _backgroundErrorColor
            : _backgroundNormalColor
        }
    }

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

    override var text: String? {
        didSet {
            guard let text = text else { return }

            self.onUpdatedText(text)
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
        semanticContentAttribute = .forceRightToLeft
        textAlignment = .right

        layer.borderColor = _borderNormalColor.cgColor
        layer.borderWidth = .dynamicToWidth(1)
        layer.cornerRadius = _cornerRadius

        setupLeftView()
        setupRightView()

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

    // MARK: - View Setup

    private func setupLeftView() {
        if let leftImage = leftImage {
            leftView = createOverlayImageView(leftImage)
            leftViewMode = .always
        }
    }

    private func setupRightView() {
        if let rightImage = rightImage {
            rightView = createOverlayImageView(
                rightImage.withConfiguration(
                    UIImage.SymbolConfiguration(
                        pointSize: .dynamicToWidth(21),
                        weight: .bold
                    )
                )
            )
            rightViewMode = .always
        }
    }

    // MARK: - Responders

    override func becomeFirstResponder() -> Bool {
        defer {
            DispatchQueue.main.async {
                self.onFinishBecomeFirstResponder()
            }
        }

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            DispatchQueue.main.async {
                self.onFinishResignFirstResponder()
            }
        }

        return super.resignFirstResponder()
    }

    // MARK: - Field Insets

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: _textInsets)
    }

    // MARK: - Helpers

    func onFinishBecomeFirstResponder() {
        onBecomeFirstResponder?()
//        // update Overlay views for becomeFirstResponder event
//        self.doUpdateLeftRightImageViewsTintColor(self._focusedIconColor)
//
//        if let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if self.shouldMoveCursorToEndOnBecomeFirstResponder {
//                self.selectedTextRange = self.textRange(
//                    from: self.endOfDocument,
//                    to: self.endOfDocument
//                )
//            }
//
//            if self.shouldKeepPlaceholderPrefixOnResignFirstResponder {
//                let placeholder: String = self.attributedPlaceholder?.string ?? self.placeholder ?? ""
//
//                if placeholder.isEmpty == false {
//                    self.text = text.replacingOccurrences(
//                        of: placeholder + " : ",
//                        with: ""
//                    )
//                    .removeUnicodeLayoutFix()
//                }
//            }
//        }
    }

    func onFinishResignFirstResponder() {
        onResignFirstResponder?()
//        if let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            // update Overlay views for resignFirstResponder event
//            self.onUpdatedText(text)
//
//            if self.shouldKeepPlaceholderPrefixOnResignFirstResponder {
//                let placeholder: String = self.attributedPlaceholder?.string ?? self.placeholder ?? ""
//
//                if text.isEmpty == false && placeholder.isEmpty == false {
//                    self.text = (placeholder + " : " + text).fixUnicodeLayout()
//                }
//            }
//        }
    }

    func onUpdatedText(_ text: String) {
        self.doUpdateLeftRightImageViewsTintColor(
            text.isEmpty ? self._unfocusedIconColor : self._focusedIconColor
        )
    }

    private func doUpdateLeftRightImageViewsTintColor(_ color: UIColor) {
        self.leftImageView?.tintColor = color
        self.rightImageView?.tintColor = color
    }

    private func createOverlayImageView(_ image: UIImage) -> UIView {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = _unfocusedIconColor
        imageView.image = image
            .resizedDynamically()?
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(_unfocusedIconColor)

        return createOverlayContainerView(imageView)
    }

    func createOverlayButton(_ button: UIButton) -> UIView {
        return createOverlayContainerView(
            button,
            overlayLength: .dynamicToWidth(50)
        )
    }

    private func createOverlayContainerView(
        _ overlayView: UIView,
        containerLength: CGFloat = .dynamicToWidth(50),
        overlayLength: CGFloat = .dynamicToWidth(25)
    ) -> UIView {

        let view = UIView(
            frame: .init(
                x: 0, y: 0,
                width: containerLength,
                height: containerLength
            )
        )

        overlayView.frame = .init(
            x: 0, y: 0,
            width: overlayLength,
            height: overlayLength
        )

        view.addSubview(overlayView)

        overlayView.center = view.center

        return view
    }
}
