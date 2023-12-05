//
//  AuthAccessibleService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkAuthAccessible: BaseService {
    var auth: AuthService { get }
}
