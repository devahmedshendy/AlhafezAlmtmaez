//
//  ObjectIdentifier.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/11/2023.
//

import Foundation

protocol AnyObjectIdentifiable: AnyObject {
    static var identifier: String { get }
}

extension AnyObjectIdentifiable {
    static var objectifier: ObjectIdentifier { ObjectIdentifier(self) }
}
