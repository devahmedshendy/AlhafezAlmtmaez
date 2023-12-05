//
//  UserService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class UserService: BaseNetworkService {
 
    // MARK: - Properties

    var activeToken: String { localRepository.getToken() }

    private lazy var localRepository: UserLocalDataRepository = .init()
    private lazy var remoteRepository: UserRemoteDataRepository = .init()

    // MARK: - User Profile

    func getCurrentUserProfile() async throws -> UserProfileModel {
        try await getUserProfile(token: activeToken)
    }

    private func getUserProfile(token: String) async throws -> UserProfileModel {
        let response = try await remoteRepository.getUserProfile(
            token: activeToken
        )

        return try unwrap(responseData: response.data)
    }
}
