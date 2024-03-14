//
//  VerifyCodeScreenService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 27/01/2024.
//

import Foundation

final class VerifyCodeScreenService: BaseScreenService {

    // MARK: - Logic

    func verify(
        dto: VerifyCodeFormDto,
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) {
        subscriptions[#function]?.cancel()

        subscriptions[#function] = publisher {
            try await self.auth.submitVerifyCode(dto: dto)
        }
        .sinkOnMain(
            onSuccess: { _ in },
            onFailure: onFailure
        )
    }
}
