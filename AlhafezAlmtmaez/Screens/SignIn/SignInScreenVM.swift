//
//  SignInScreenVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/12/2023.
//

import Foundation

final class SignInScreenVM: BaseFormVM {

    @PublishedOnMainUnlessNil
    private(set) var onRequestResult: TokenAndPhoneResponseResult? = nil

    // MARK: - Properties

    private lazy var service: SignInScreenService = .init()

    // MARK: - Logic

    func doSignIn(phoneNumber: String) {
        onClearValidation()
        onStartLoading()

        service.signin(
            with: phoneNumber,
            onSuccess: { [weak self] result in
                self?.onStopLoading()
                self?.onRequestResult = result
            },
            onFailure: onLoadingFailure(_:)
        )
    }
}
