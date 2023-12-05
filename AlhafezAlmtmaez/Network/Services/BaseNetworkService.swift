//
//  BaseNetworkService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

class BaseNetworkService: BaseService,
                          NetworkServiceFeatures,
                          NetworkAuthAccessible {

    // MARK: - Properties

    private(set) lazy var auth: AuthService = .init()

    // MARK: - LifeCycle

    deinit {
        print(Self.self)
    }

}
