//
//  UIApplication+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIApplication {
    static var isRTL: Bool {
        shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

// MARK: - Dimensions

extension UIApplication {

    private static var windowScene: UIWindowScene? {
        return shared.connectedScenes.first as? UIWindowScene
    }

    private static var topViewController: UIViewController? {
        return windowScene?
            .windows
            .first?
            .rootViewController?
            .topViewController
    }

    static var screenWidth: CGFloat {
        return windowScene?
            .screen
            .bounds
            .size
            .width ?? .zero
    }

    static var screenHeight: CGFloat {
        return windowScene?
            .screen
            .bounds
            .size
            .height ?? .zero
    }

    static var isStatusBarHidden: Bool {
        return windowScene?
            .statusBarManager?
            .isStatusBarHidden ?? true
    }

    static var statusBarHeight: CGFloat {
        return windowScene?
            .statusBarManager?
            .statusBarFrame
            .height ?? .zero
    }

    static var isNavigationBarHidden: Bool {
        return topViewController?
            .navigationController?
            .isNavigationBarHidden ?? true
    }

    static var navigationBarHeight: CGFloat {
        return topViewController?
            .navigationBarHeight ?? .zero
    }

    static var safeAreaInsets: UIEdgeInsets {
        return windowScene?
            .windows
            .first?
            .safeAreaInsets ?? .zero
    }

    static var safeAreaTopHeight: CGFloat {
        return safeAreaInsets.top
    }

    static var safeAreaBottomHeight: CGFloat {
        return safeAreaInsets.bottom
    }
}
