//
//  UIViewNibbable.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/11/2023.
//

import UIKit

protocol UIViewNibbable: UIView {
    static var nib: UINib { get }
}

extension UIViewNibbable {
    static var nib: UINib {
        .init(
            nibName: identifier,
            bundle: .init(for: Self.self)
        )
    }
}
