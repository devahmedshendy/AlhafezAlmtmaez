//
//  UIView+Extension.swift
//  Sheryan
//
//  Created by Ahmed Shendy on 03/02/2023.
//  Copyright © 2023 Sheryan. All rights reserved.
//

import UIKit

extension UIView: UIViewNibbable, StringIdentifiable, AnyObjectIdentifiable { }

extension UIView {
    var globalFrame: CGRect {
        return convert(bounds, to: window)
    }
}

extension UIView {
    func setupXib() {
        let contentView = loadNib()

        insertSubview(contentView, at: 0)

        contentView.frame = self.frame

        // Constraints Setup
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func loadNib() -> UIView {
        Self.nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIView {
    func embed(subview: UIView, inContainerView container: UIView) {
        container.addSubview(subview)
        
        // Constraints Configuration
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            subview.topAnchor.constraint(equalTo: container.topAnchor),
            subview.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}
