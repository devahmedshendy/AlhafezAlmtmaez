//
//  MyAccountScreenService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import Foundation

final class MyAccountScreenService: BaseScreenService {

    // MARK: - Logic

    func signout(
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) {
        subscriptions[#function]?.cancel()

        subscriptions[#function] = publisher {
            try await self.auth.signout()
        }
        .sinkOnMain(
            onSuccess: { _ in },
            onFailure: onFailure
        )
    }
}
