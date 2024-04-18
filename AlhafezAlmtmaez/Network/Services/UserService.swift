//
//  UserService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class UserService: BaseNetworkService {
 
    // MARK: - Properties

    @CachedCurrentUserToken
    var cachedCurrentUserToken: String

    private lazy var localRepository: UserLocalDataRepository = .init()
    private lazy var remoteRepository: UserRemoteDataRepository = .init()

    // MARK: - Token

    func getCurrentUserToken() -> String {
        localRepository.getCurrentUserToken() ?? ""
    }

    func storeCurrentUserToken(_ token: String) {
        localRepository.storeCurrentUserToken(token)
    }

    func cacheCurrentUserToken(_ token: String) {
        localRepository.cacheCurrentUserToken(token)
    }

    func removeCurrentUserToken() {
        localRepository.removeCurrentUserToken()
    }

    // MARK: - User Profile

    func getCurrentUserProfile() async throws -> UserProfileModel {
        try await getUserProfile(token: cachedCurrentUserToken)
    }

    private func getUserProfile(token: String) async throws -> UserProfileModel {
        let response = try await remoteRepository.getUserProfile(
            token: cachedCurrentUserToken
        )

        return try unwrap(responseData: response.data)
    }

    func cacheCurrentUserProfile(_ profile: UserProfileModel) {
        localRepository.cacheCurrentUserProfile(profile)
    }

    func removeCurrentUserProfile() {
        localRepository.removeCurrentUserProfile()
    }

    // MARK: - Evaluations

    func getEvaluations() async throws -> [EvaluationModel] {
        let response = try await remoteRepository.getEvaluations(
            token: cachedCurrentUserToken,
            date: "10/2023"
        )

        let data = try unwrap(responseData: response.data)

        return data.evaluations
    }
}
