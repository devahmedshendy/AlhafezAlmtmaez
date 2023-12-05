//
//  FormSubmitButton.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

class FormSubmitButton: UIButton {

    // MARK: - Theme

    var _cornerRadius: CGFloat { .formCornerRadius }

    // MARK: - Properties

    var title: String? {
        didSet {
            setupAttributedTitle()
        }
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

    // MARK: - LifeCycle

    func setup() {
        if configuration == nil {
            configuration = .plain()
        }

        configuration?.titleAlignment = .leading
        configuration?.contentInsets = .formButtonContentInsets

        backgroundColor = .formSubmitBackground
        configuration?.baseForegroundColor = .white
        configuration?.baseBackgroundColor = .clear

        configuration?.image = .init(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: .dynamicToWidth(11),
                weight: .heavy
            )
        )
        configuration?.imagePlacement = .trailing

        if let imageView = imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(
                    equalTo: self.centerYAnchor
                ),
                imageView.leftAnchor.constraint(
                    equalTo: self.leftAnchor,
                    constant: .dynamicToWidth(16)
                )
            ])
        }

        contentHorizontalAlignment = .right
        semanticContentAttribute = .forceRightToLeft

        layer.cornerRadius = _cornerRadius

        setupAttributedTitle()
    }

    // MARK: - View Setup

    private func setupAttributedTitle() {
        configuration?.attributedTitle = .formSubmitTitle(
            title ?? configuration?.title ?? titleLabel?.text ?? ""
        )
    }
}
