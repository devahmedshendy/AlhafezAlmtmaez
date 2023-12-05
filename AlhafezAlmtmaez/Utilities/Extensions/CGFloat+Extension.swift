//
//  CGFloat+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension CGFloat {
    static var isSmallWidth: Bool { screenWidth <= 400 }

    static var screenWidth: CGFloat { UIApplication.screenWidth }
    static var screenHeight: CGFloat { UIApplication.screenHeight }
    static var statusBarHeight: CGFloat { UIApplication.statusBarHeight }
    static var navigationBarHeight: CGFloat { UIApplication.navigationBarHeight }

    static var screenContentPadding: CGFloat { .dynamicToWidth(27) }
    static var tabbarBottomPadding: CGFloat { .dynamicToWidth(33) }

    static func dynamicToWidth(_ value: CGFloat) -> CGFloat {
        return value * screenWidth / 375
    }
}
