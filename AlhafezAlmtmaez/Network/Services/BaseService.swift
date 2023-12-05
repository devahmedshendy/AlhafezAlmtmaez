//
//  BaseService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation
import Combine

class BaseService: NSObject, BasicServiceFeatures {

    // MARK: - Properties

    lazy var subscriptions: [String : AnyCancellable] = [:]

    // MARK: - LifeCycle

    deinit {
        print(Self.self)
    }
}
