//
//  NSDirectionalEdgeInsets+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static var formButtonContentInsets: NSDirectionalEdgeInsets {
        let verticalInset: CGFloat = .dynamicToWidth(11)
        let horizontalInset: CGFloat = .dynamicToWidth(16)

        return .init(
            top: verticalInset,
            leading: horizontalInset,
            bottom: verticalInset,
            trailing: horizontalInset
        )
    }
}
