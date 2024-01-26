//
//  AuthService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

typealias TokenAndPhoneResponseResult = AuthService.TokenAndPhoneResponseResult

final class AuthService: BaseService, NetworkServiceFeatures {

    struct TokenAndPhoneResponseResult {
        let phoneText: String
        let verifyToken: String
        let toast: String

        init(phoneText: String, verifyToken: String, toast: String) {
            self.phoneText = phoneText
            self.verifyToken = verifyToken
            self.toast = toast
        }
    }

    // MARK: - Properties

    private lazy var user: UserService = .init()
    private lazy var session: UserSessionService = .init()

    private lazy var repository: AuthDataRepository = .init()

    // MARK: - Logic

    func validateCurrentUser() async throws {
        _ = try await user.getCurrentUserProfile()

        session.setActive()
    }

    // MARK: - Request Verification Code

    func requestVerificationCode(
        for phoneNumber: String
    ) async throws -> TokenAndPhoneResponseResult {
        let response = try await repository.requestVerificationCode(
            phoneNumber: phoneNumber
        )

        let data = try unwrap(responseData: response.data)

        return .init(
            phoneText: data.phone_text,
            verifyToken: data.access_token,
            toast: response.message
        )
    }
}
