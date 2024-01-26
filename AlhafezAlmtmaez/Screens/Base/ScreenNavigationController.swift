//
//  ScreenNavigationController.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import UIKit

final class ScreenNavigationController: UINavigationController, UINavigationControllerDelegate {

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}
