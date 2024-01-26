//
//  UnderlinedButton.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 06/12/2023.
//

import UIKit

final class UnderlinedButton: UIButton {

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

        backgroundColor = .clear
        configuration?.baseForegroundColor = .white
        configuration?.baseBackgroundColor = .clear

        configuration?.imagePlacement = .trailing

        contentHorizontalAlignment = .center
//        semanticContentAttribute = .forceRightToLeft

        setupAttributedTitle()
    }

    // MARK: - View Setup

    private func setupAttributedTitle() {
        configuration?.attributedTitle = .underlinedTitle(
            title ?? configuration?.title ?? titleLabel?.text ?? ""
        )
    }
}
