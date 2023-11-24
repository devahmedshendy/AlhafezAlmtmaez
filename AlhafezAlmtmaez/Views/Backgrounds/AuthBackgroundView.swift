//
//  AuthBackgroundView.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 13/11/2023.
//

import UIKit

final class AuthBackgroundView: UIView {

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupXib()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupXib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    private func setup() {

    }
}
