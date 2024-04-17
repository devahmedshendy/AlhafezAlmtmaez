//
//  AuthDataRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/12/2023.
//

import Foundation

final class AuthDataRepository: ServerRemoteRepository {
    func requestVerificationCode(
        phoneNumber: String
    ) async throws -> RequestVerificationCodeEndpoint.Response {
        try await request(
            endpoint: RequestVerificationCodeEndpoint(
                phoneNumber: phoneNumber
            )
        )
    }

    func submitVerifyCode(
        dto: VerifyCodeFormDto
    ) async throws -> VerifyCodeEndpoint.Response {
        try await request(
            endpoint: VerifyCodeEndpoint(dto: dto)
        )
    }

    func signout(
        token: String
    ) async throws -> SignOutEndpoint.Response {
        try await request(
            endpoint: SignOutEndpoint(token: token)
        )
    }
}
