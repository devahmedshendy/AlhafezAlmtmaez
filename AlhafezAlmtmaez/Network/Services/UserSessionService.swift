//
//  UserSessionService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation
import Combine

final class UserSessionService: BaseService {

    // MARK: - Properties

    @PublishedUserSessionStateOnMain
    var state: UserSession.State

    private lazy var repository: UserSessionRepository = .shared

    // MARK: - Logic

    func setActive() {
        repository.setActiveSession()
    }

    func setInactive() {
        repository.setInactiveState()
    }
}
