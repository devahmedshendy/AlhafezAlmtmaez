//
//  UIViewController+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIViewController {
    var navigationBarHeight: CGFloat {
        guard
            let navigationBar = self.navigationController?.navigationBar
        else { return .zero }

        return navigationBar.isHidden
        ? .zero
        : navigationBar.frame.height
    }
    
    var topViewController: UIViewController {
        switch self {
        case is UINavigationController:
            return (self as! UINavigationController)
                .visibleViewController?.topViewController ?? self

        case is UITabBarController:
            return (self as! UITabBarController)
                .selectedViewController?.topViewController ?? self

        default:
            return presentedViewController?.topViewController ?? self
        }
    }
}
