//
//  SplashScreenService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class SplashScreenService: BaseScreenService {

    // MARK: - Logic

    func handleOnStartup(
        onFailure: @escaping (_ error: any AppError) -> Void
    ) {
        subscriptions[#function]?.cancel()

        subscriptions[#function] = publisher {
            try await self.auth.validateCurrentUser()
        }
        .sinkOnMain(
            onSuccess: { _ in },
            onFailure: onFailure
        )
    }
}
