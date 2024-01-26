//
//  ToastManager.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/12/2023.
//

import UIKit
import Toast

final class ToastManager {

    // MARK: - Properties

    private weak var superview: UIView?

    // MARK: - inits

    init(superview: UIView) {
        self.superview = superview
    }

    // MARK: - Methods

    func show(_ message: String, duration: CGFloat = 2.75) {
        superview?.makeToast(
            message,
            duration: duration,
            position: .bottom
        )
    }
}
