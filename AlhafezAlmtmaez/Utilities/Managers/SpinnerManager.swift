//
//  SpinnerManager.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/12/2023.
//

import UIKit
import Toast

final class SpinnerManager {

    // MARK: - Properties

    private weak var superview: UIView?

    // MARK: - inits

    init(superview: UIView) {
        self.superview = superview
    }

    // MARK: - Methods

    func showLoading() {
        hideLoading()

        superview?.makeToastActivity(.center)
    }

    func hideLoading() {
        superview?.hideToastActivity()
    }
}
