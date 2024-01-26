//
//  FormFieldBaseLabel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

class FormFieldBaseLabel: UILabel {

    // MARK: - Theme

    var _normalFont: UIFont { .avenirArabic_500(size: 16) }
    var _focusedFont: UIFont { .avenirArabic_500(size: 16) }
    var _textColor: UIColor { .black }

    // MARK: - Properties

    override var text: String? {
        didSet {
            setupAttributedText()
        }
    }

    override func becomeFirstResponder() -> Bool {
        defer {
            DispatchQueue.main.async {
                self.font = self._focusedFont
            }
        }
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            DispatchQueue.main.async {
                self.font = self._normalFont
            }
        }
        return super.resignFirstResponder()
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
        textColor = _textColor
//        semanticContentAttribute = .forceRightToLeft
        textAlignment = .right

        setupAttributedText()
    }

    // MARK: - View Setup

    private func setupAttributedText() {
        attributedText = .formLabelAttributedString(
            text,
            font: _normalFont
        )
    }
}
