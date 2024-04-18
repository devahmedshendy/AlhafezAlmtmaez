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

    func viewDidLoad() {
        onStartLoading()

        service.getCurrentUserEvaluations(
            onSuccess: { [weak self] result in
                self?.data = result
                self?.onStopLoading()
            },
            onFailure: onLoadingFailure(_:)
        )
    }

    func refreshEvaluations() {
        onStartRefreshing()

        service.getCurrentUserEvaluations(
            onSuccess: { [weak self] result in
                self?.data = result
                self?.onStopRefreshing()
            },
            onFailure: onRefreshingFailure(_:)
        )
    }
}
