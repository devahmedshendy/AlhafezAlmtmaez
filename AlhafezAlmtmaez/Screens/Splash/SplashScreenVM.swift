//
//  SplashScreenVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class SplashScreenVM: BaseScreenVM {

    // MARK: - Properties

    private lazy var service: SplashScreenService = .init()

    // MARK: - Logic

    func onViewDidLoad() {
        onStartLoading()

        service.handleOnStartup(
            onFailure: onLoadingFailure(_:)
        )
    }
}
