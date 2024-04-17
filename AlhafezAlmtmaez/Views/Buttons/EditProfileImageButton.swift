//
//  EditProfileImageButton.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import UIKit

@IBDesignable
final class EditProfileImageButton: UIButton {

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

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds
            .insetBy(
                dx: -.dynamicToWidth(10),
                dy: -.dynamicToWidth(10)
            )
            .contains(point)
    }

    // MARK: - LifeCycle

    func setup() {
        configuration?.image = imageView?.image ?? .editPenIcon
        configuration?.contentInsets = .init(
            top: .dynamicToWidth(7) + .dynamicToWidth(4),
            leading: .dynamicToWidth(7) + .dynamicToWidth(4),
            bottom: .dynamicToWidth(7) + .dynamicToWidth(4),
            trailing: .dynamicToWidth(7) + .dynamicToWidth(4)
        )

        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = .dynamicToWidth(1)
    }
}
