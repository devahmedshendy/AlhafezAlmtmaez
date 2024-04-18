//
//  UITableView+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 17/04/2024.
//

import UIKit

extension UITableView {

    // MARK: Cell

    func registerCellClass<T>(_ type: T.Type) where T: (UITableViewCell) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func registerCellNib<T>(_ type: T.Type) where T: (UITableViewCell) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: (UITableViewCell) {
        dequeueReusableCell(
            withIdentifier: T.identifier,
            for: indexPath
        ) as! T
    }

    func dequeueReusableCell<T>(_ type: T.Type) -> T where T: (UITableViewCell) {
        dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
}
