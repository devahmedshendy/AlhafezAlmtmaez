//
//  UIImage+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit

extension UIImage {

    // Source: https://gist.github.com/ppamorim/cc79170422236d027b2b#gistcomment-3817698
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let targetSize = CGSize(width: self.size.width + insets.left + insets.right,
                                height: self.size.height + insets.top + insets.bottom)
        let targetOrigin = CGPoint(x: insets.left, y: insets.top)

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: targetOrigin, size: self.size))
        }
        .withRenderingMode(renderingMode)
    }

    func resized(toWidth width: CGFloat) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }

        let canvasSize = CGSize(
            width: width,
            height: CGFloat(ceil(width/size.width * size.height))
        )

        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)

        draw(in: CGRect(origin: .zero, size: canvasSize))

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func resizedDynamically() -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }

        let width: CGFloat = .dynamicToWidth(size.width)

        let canvasSize = CGSize(
            width: width,
            height: CGFloat(ceil(width/size.width * size.height))
        )

        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)

        draw(in: CGRect(origin: .zero, size: canvasSize))

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImage {
    var heightToWidthRatio: CGFloat {
        size.height / size.width
    }

    var widthToHeightRatio: CGFloat {
        size.width / size.height
    }
}
