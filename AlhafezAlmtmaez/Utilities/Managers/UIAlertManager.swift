//
//  UIAlertManager.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/12/2023.
//

import UIKit

final class UIAlertManager {

    // MARK: - Properties

    weak var vc: UIViewController?

    // MARK: - inits

    init(vc: UIViewController) {
        self.vc = vc
    }

    // MARK: - Methods

    func showSessionExpiredAlert(onOK: @escaping () -> Void) {
        let actions: [UIAlertAction] = [
            UIAlertAction(
                title: .alert.OK,
                style: .default,
                handler: { _ in onOK() }
            )
        ]

        showAlert(
            title: .alert.ExpiredSessionTitle,
            body: .alert.ExpiredSessionDescription,
            actions: actions
        )
    }

    func showCancellableActionSheet(
        withTitle title: String,
        actions : [(title: String, handler: () -> Void)]
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )

        for action in actions {
            alert.addAction(
                UIAlertAction(
                    title: action.title,
                    style: .default,
                    handler: { _ in action.handler() }
                )
            )
        }

        alert.addAction(
            UIAlertAction(
                title: .alert.Cancel,
                style: .cancel,
                handler: nil
            )
        )

        vc?.present(alert, animated: true)
    }

    // MARK: - Helpers

    private func showAlert(title: String?, body: String? = nil, actions: [UIAlertAction]) {
        let ac = UIAlertController(
            title: title,
            message: body,
            preferredStyle: .alert
        )

        for action in actions {
            ac.addAction(action)
        }

        DispatchQueue.main.async {
            self.vc?.present(ac, animated: true, completion: nil)
        }
    }

    private func showActionSheet(title: String?, body: String? = nil, actions: [UIAlertAction]) {
        let ac = UIAlertController(
            title: title,
            message: body,
            preferredStyle: .actionSheet
        )

        for action in actions {
            ac.addAction(action)
        }

        DispatchQueue.main.async {
            self.vc?.present(ac, animated: true, completion: nil)
        }
    }
}

