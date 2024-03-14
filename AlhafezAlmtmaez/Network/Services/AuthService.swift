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
        let token = user.getCurrentUserToken()
        user.cacheCurrentUserToken(token)
        let profile = try await user.getCurrentUserProfile()

        activateSession(
            accessToken: token,
            profile: profile
        )
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

    func submitVerifyCode(
        dto: VerifyCodeFormDto
    ) async throws {
        let response = try await repository.submitVerifyCode(dto: dto)

        let data = try unwrap(responseData: response.data)

        activateSession(
            accessToken: data.access_token, 
            profile: data.user
        )
    }

    private func activateSession(
        accessToken: String,
        profile: UserProfileModel
    ) {
        user.storeCurrentUserToken(accessToken)
        user.cacheCurrentUserToken(accessToken)
        user.cacheCurrentUserProfile(profile)

        session.setActive()
    }
}
