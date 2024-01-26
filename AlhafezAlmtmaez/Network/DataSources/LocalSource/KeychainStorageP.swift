//
//  KeychainStorageP.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

protocol KeychainStorageP {
    static var account: String { get }

    func string(forService service: String) throws -> String?
    func removeData(forService service: String) throws

    func getValue<T>(ofType type: T.Type, forService service: String) throws -> T? where T: Decodable
    func upset<T>(_ value: T, forService service: String) throws where T: Encodable
}

extension KeychainStorageP {
    static var account: String { Bundle.main.bundleIdentifier ?? "com.alhafez-almtmaez.ios" }
}
