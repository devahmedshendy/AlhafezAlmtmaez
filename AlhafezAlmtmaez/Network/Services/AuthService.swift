//
//  AuthService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class AuthService: BaseService, NetworkServiceFeatures {

    // MARK: - Properties

    private lazy var user: UserService = .init()
    private lazy var session: UserSessionService = .init()

    // MARK: - Logic

    func validateCurrentUser() async throws {
        _ = try await user.getCurrentUserProfile()

        session.setActive()
    }
}
