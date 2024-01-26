//
//  SignInScreenService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/12/2023.
//

import Foundation

final class SignInScreenService: BaseScreenService {

    // MARK: - Logic

    func signin(
        with phoneNumber: String,
        onSuccess: @escaping (_ result: TokenAndPhoneResponseResult) -> Void,
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) {
        subscriptions[#function]?.cancel()

        subscriptions[#function] = publisher {
            try await self.auth.requestVerificationCode(for: phoneNumber)
        }
        .sinkOnMain(
            onSuccess: onSuccess,
            onFailure: onFailure
        )
    }
}
