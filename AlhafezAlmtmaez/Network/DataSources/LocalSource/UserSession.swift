//
//  UserSession.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import SwiftUI

final class UserSession {

    static let shared: UserSession = .init()

    enum State: Equatable {
        case startup
        case active
        case inactive
    }

    // MARK: - States

    @PublishedOnMain
    private(set) var state: State = .startup

    // MARK: - Properties

    private lazy var lock: NSLock = .init()

    // MARK: - LifeCycle

    private init() { }

    // MARK: - Logic

    func toActiveState() {
        lock.lock()
        defer { lock.unlock()}

        state = .active
    }

    func toInactiveState() {
        lock.lock()
        defer { lock.unlock() }

        state = .inactive
    }
}
