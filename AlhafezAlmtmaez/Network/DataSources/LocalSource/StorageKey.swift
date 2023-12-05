//
//  StorageKey.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

enum StorageKey {
    static let is_first_time_run: String = StorageKey.Name.is_first_time_run.rawValue
    static let token: String = StorageKey.Name.token.rawValue

    enum Name: String, CaseIterable {
        case token
        case is_first_time_run
    }

    static var allKeys: [String] { Name.allCases.map(\.rawValue) }
}
