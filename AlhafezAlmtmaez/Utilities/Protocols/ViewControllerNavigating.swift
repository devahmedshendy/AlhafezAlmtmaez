//
//  ViewControllerNavigating.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/12/2023.
//

import UIKit

protocol ViewControllerNavigating: UIViewController { }

extension ViewControllerNavigating {
    func goToVerifyCodeScreen(
        phoneNumber: String,
        result: TokenAndPhoneResponseResult
    ) {
        let vc = VerifyCodeScreen()
        vc.phoneNumber = phoneNumber
        vc.verifyToken = result.verifyToken
        vc.onNavigatedMessage = result.toast + " " + result.phoneText.ignoreLocalization()

        pushToViewController(vc)
    }
}

// MARK: - Helpers

extension ViewControllerNavigating {
    func removeViewController<T: UIViewController>(
        _ vc: T, animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        if let index = self.navigationController?.viewControllers.firstIndex(where: { $0 == vc }) {
            self.navigationController?.viewControllers.remove(at: index)
        }
    }

    func pushToViewController<T: UIViewController>(
        _ vc: T, animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.navigationController?.pushViewController(vc, animated: animated)
            CATransaction.commit()
        }
    }

    private func replaceViewController<T: UIViewController>(
        _ vc: T,
        with withVC: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.navigationController?.viewControllers.removeAll(where: { $0 is T })
                completion?()
            }

            self.navigationController?.pushViewController(withVC, animated: animated)
            CATransaction.commit()
        }
    }
}
