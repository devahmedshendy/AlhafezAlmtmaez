//
//  HomeScreenService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

final class HomeScreenService: BaseScreenService {

    // MARK: - Properties

    private lazy var user: UserService = .init()

    // MARK: - Logic

    func getCurrentUserEvaluations(
        ofMonth month: String,
        onSuccess: @escaping (_ result: [EvaluationVM]) -> Void,
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) {
        subscriptions[#function]?.cancel()

        subscriptions[#function] = publisher {
            try await self.user.getEvaluations(ofMonth: month)
        }
        .map { $0.map(EvaluationVM.init(from:)) }
        .sinkOnMain(
            onSuccess: onSuccess,
            onFailure: onFailure
        )
    }
}
