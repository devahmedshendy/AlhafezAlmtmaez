//
//  KeyboardObserver.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import UIKit

protocol KeyboardObserverDelegate: AnyObject {
    func onKeyboardBecomesVisible()
    func onKeyboardHeightChange(_ keyboardHeight: CGFloat)
}

final class KeyboardObserver: NSObject {

    static let shared: KeyboardObserver = .init()

    // MARK: - Properties

    weak var delegate: KeyboardObserverDelegate?

    private(set) var isKeyboardVisible: Bool = false

    // MARK: - LifeCycle



    // MARK: - Observe

    func startObserveKeyboardVisibility() {
        stopObserveKeyboardVisibility()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func onKeyboardWillShow(_ notification: NSNotification) {
        isKeyboardVisible = true
        delegate?.onKeyboardBecomesVisible()

        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            delegate?.onKeyboardHeightChange(0)
            return
        }

        delegate?.onKeyboardHeightChange(keyboardSize.height)
    }

    @objc private func onKeyboardWillHide(_ notification: NSNotification) {
        isKeyboardVisible = false
        delegate?.onKeyboardHeightChange(0)
    }

    func stopObserveKeyboardVisibility() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
