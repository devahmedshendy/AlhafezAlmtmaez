//
//  MyAccountScreenVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import Foundation

final class MyAccountScreenVM: BaseFormVM {

    // MARK: - Properties

    private lazy var service: MyAccountScreenService = .init()

    // MARK: - Logic

    func signout() {
        onStartLoading()

        service.signout(
            onFailure: onLoadingFailure(_:)
        )
    }
}
