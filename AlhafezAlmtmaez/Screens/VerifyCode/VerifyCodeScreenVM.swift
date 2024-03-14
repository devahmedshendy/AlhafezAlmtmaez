//
//  VerifyCodeScreenVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 27/01/2024.
//

import Foundation

final class VerifyCodeScreenVM: BaseFormVM {

    // MARK: - Properties

    private lazy var service: VerifyCodeScreenService = .init()

    // MARK: - Logic

    func verify(dto: VerifyCodeFormDto) {
        onClearValidation()
        onStartLoading()

        service.verify(
            dto: dto,
            onFailure: onLoadingFailure(_:)
        )
    }
}
