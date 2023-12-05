//
//  BaseScrollableScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import UIKit

class BaseScrollableScreen: BaseScreen {

    // MARK: - Subviews

    var scrollView: UIScrollView? {
        view.subviews
            .first(where: { $0 is UIScrollView }) as? UIScrollView
    }

    // MARK: - KeyboardObserverDelegate

    override func onKeyboardHeightChange(_ keyboardHeight: CGFloat) {
        guard let scrollView = scrollView else  { return }

        let safeAreaBottomHeight = UIApplication.safeAreaBottomHeight
        var tabBarHeight: CGFloat = 0
        if let tabBar = self.tabBarController?.tabBar {
            tabBarHeight = tabBar.isHidden ? 0 : tabBar.frame.height - safeAreaBottomHeight
        }

        let responder = findFirstResponder(inView: scrollView)
        let responderBottomInset: CGFloat = UIApplication.screenHeight - (responder?.globalFrame.maxY ?? 0)

        let isKeyboardOpen = keyboardHeight != 0
        let isKeyboardOverlapping = keyboardHeight >= (responderBottomInset - .formFieldsStackSpacing)

        var bottomInset: CGFloat
        if isKeyboardOpen && isKeyboardOverlapping {
            let idealPadding: CGFloat = .formFieldsStackSpacing
            let currentPadding: CGFloat = responderBottomInset > keyboardHeight ? responderBottomInset - keyboardHeight : 0

            bottomInset = keyboardHeight + (idealPadding - currentPadding) - safeAreaBottomHeight - tabBarHeight

        } else if isKeyboardOpen {
            bottomInset = scrollView.contentInset.bottom

        } else {
            bottomInset = 0
        }

        let insets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: bottomInset,
            right: 0
        )

        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
}
