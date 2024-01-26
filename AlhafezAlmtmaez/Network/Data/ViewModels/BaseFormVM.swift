//
//  BaseFormVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 26/01/2024.
//

import Foundation

class BaseFormVM: BaseVM {

    // MARK: - States

    @PublishedOnMain
    private(set) var onValidation: [String : String] = [:]

    // MARK: - Events

    // Loading

    override func onLoadingFailure(_ error: ApplicationError) {
        super.onLoadingFailure(error)
        self.onResponseValidation(error.validation)
    }

    // Loading More

    override func onLoadingMoreFailure(_ error: ApplicationError) {
        super.onLoadingMoreFailure(error)
        self.onResponseValidation(error.validation)
    }

    // Refreshing

    override func onRefreshingFailure(_ error: ApplicationError) {
        super.onRefreshingFailure(error)
        self.onResponseValidation(error.validation)
    }

    // MARK: - Helpers

    func onClearValidation() {
        onResponseValidation([:])
    }

    private func onResponseValidation(_ validation: [String : String]) {
        self.onValidation = validation
    }
}
