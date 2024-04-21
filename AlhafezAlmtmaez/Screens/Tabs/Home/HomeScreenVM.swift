//
//  HomeScreenVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

final class HomeScreenVM: BaseVM {

    // MARK: - States

    @PublishedOnMain
    private(set) var data: [EvaluationVM] = []

    // MARK: - Properties

    private lazy var service: HomeScreenService = .init()

    // MARK: - Logic

    func getEvaluations(ofMonth month: String) {
        onStartLoading()

        service.getCurrentUserEvaluations(
            ofMonth: month,
            onSuccess: { [weak self] result in
                self?.data = result
                self?.onStopLoading()
            },
            onFailure: onLoadingFailure(_:)
        )
    }

    func refreshEvaluations(ofMonth month: String) {
        onStartRefreshing()

        service.getCurrentUserEvaluations(
            ofMonth: month,
            onSuccess: { [weak self] result in
                self?.data = result
                self?.onStopRefreshing()
            },
            onFailure: onRefreshingFailure(_:)
        )
    }
}
