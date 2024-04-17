//
//  ProfileImageView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import UIKit
import Combine

@IBDesignable
final class ProfileImageView: UIImageView {

    // MARK: - LifeCycle

    override init(image: UIImage?) {
        super.init(image: image)

        setup()
    }

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

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setup()
    }

    // MARK: - Setup

    func setup() {
        backgroundColor = .clear
        contentMode = .scaleAspectFill
        layer.borderWidth = .dynamicToWidth(5)
        layer.borderColor = UIColor.white.cgColor
    }
}
