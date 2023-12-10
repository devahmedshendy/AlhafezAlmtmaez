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

    var onBecomeFirstResponder: (() -> Void)?
    var onResignFirstResponder: (() -> Void)?

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

    override var text: String? {
        didSet {
            guard let text = text else { return }

            self.doUpdatedText(text)
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

    func doFinishBecomeFirstResponder() {
        onBecomeFirstResponder?()
    }

    func onFinishResignFirstResponder() {
        onResignFirstResponder?()
    }

    private func doUpdatedText(_ text: String) {
        self.doUpdateLeftRightImageViewsTintColor(
            text.isEmpty ? self._unfocusedIconColor : self._focusedIconColor
        )
    }

    private func doUpdateLeftRightImageViewsTintColor(_ color: UIColor) {
        self.leftImageView?.tintColor = color
        self.rightImageView?.tintColor = color
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
            DispatchQueue.main.async {
                self.font = self._focusedFont
                self.backgroundColor = self._backgroundFocusedColor
                self.layer.borderColor = self._borderFocusedColor.cgColor
                self.doFinishBecomeFirstResponder()
            }
        }

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            DispatchQueue.main.async {
                self.font = self._normalFont
                self.backgroundColor = self._backgroundNormalColor
                self.layer.borderColor = self._borderNormalColor.cgColor
                self.onFinishResignFirstResponder()
            }
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

// MARK: - View Setup

extension FormTextField {
    // TODO: Maybe I need it later.
//    private func setupLeftView() {
//        if let leftImage = leftImage {
//            leftView = createOverlayImageView(leftImage)
//            leftViewMode = .always
//        }
//    }
//
//    private func setupRightView() {
//        if let rightImage = rightImage {
//            rightView = createOverlayImageView(
//                rightImage.withConfiguration(
//                    UIImage.SymbolConfiguration(
//                        pointSize: .dynamicToWidth(21),
//                        weight: .bold
//                    )
//                )
//            )
//            rightViewMode = .always
//        }
//    }
//
//    private func createOverlayImageView(_ image: UIImage) -> UIView {
//        let imageView = UIImageView()
//        imageView.contentMode = .center
//        imageView.tintColor = _unfocusedIconColor
//        imageView.image = image
//            .resizedDynamically()?
//            .withRenderingMode(.alwaysTemplate)
//            .withTintColor(_unfocusedIconColor)
//
//        return createOverlayContainerView(imageView)
//    }
//
//    func createOverlayButton(_ button: UIButton) -> UIView {
//        return createOverlayContainerView(
//            button,
//            overlayLength: .dynamicToWidth(50)
//        )
//    }
//
//    private func createOverlayContainerView(
//        _ overlayView: UIView,
//        containerLength: CGFloat = .dynamicToWidth(50),
//        overlayLength: CGFloat = .dynamicToWidth(25)
//    ) -> UIView {
//
//        let view = UIView(
//            frame: .init(
//                x: 0, y: 0,
//                width: containerLength,
//                height: containerLength
//            )
//        )
//
//        overlayView.frame = .init(
//            x: 0, y: 0,
//            width: overlayLength,
//            height: overlayLength
//        )
//
//        view.addSubview(overlayView)
//
//        overlayView.center = view.center
//
//        return view
//    }
}
