//
//  NibLoadable.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/11/2023.
//

//import UIKit
//
//protocol NibLoadable: UIView, UIViewNibbable {
//
//    var contentView: UIView! { get set }
//
//    func loadNib()
//}
//
//extension NibLoadable {
//    func loadNib() {
//        let nib = UINib(
//            nibName: String(describing: Self.self),
//            bundle: nil
//        )
//        nib.instantiate(withOwner: self, options: nil)
//
//        contentView.frame = bounds
//
//        insertSubview(contentView, at: 0)
//    }
//}
