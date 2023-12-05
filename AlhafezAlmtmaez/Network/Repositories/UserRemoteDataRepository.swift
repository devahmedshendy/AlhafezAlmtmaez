//
//  UserRemoteDataRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class UserRemoteDataRepository: ServerRemoteRepository {

    func getUserProfile(
        token: String
    ) async throws -> UserProfileEndpoint.Response {
        try await request(
            endpoint: UserProfileEndpoint(
                token: token
            )
        )
    }

}
