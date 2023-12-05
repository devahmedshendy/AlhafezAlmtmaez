//
//  UserSessionRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation
import Combine

final class UserSessionRepository {

    static let shared: UserSessionRepository = .init()

    // MARK: - Properties

    @PublishedUserSessionStateOnMain
    var state: UserSession.State

    private lazy var session: UserSession = .shared

    // MARK: - LifeCycle

    private init() { }

    // MARK: - Logic

    func setActiveSession() {
        session.toActiveState()
    }

    func setInactiveState() {
        session.toInactiveState()
    }
}
