//
//  BaseVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

class BaseVM {

    // MARK: - States

    @PublishedOnMain
    private(set) var isLoading: Bool = false

    @PublishedOnMain
    private(set) var isRefreshing: Bool = false

    @PublishedOnMain
    private(set) var isLoadingMore: Bool = false

    @PublishedOnMainUnlessNil
    private(set) var onToastMessage: String? = nil

    // MARK: - Events

    // Loading

    func onStartLoading() {
        self.isLoading = true
    }

    func onStopLoading() {
        self.isLoading = false
    }

    func onLoadingSuccess(_ message: String) {
        self.onStopLoading()
        self.onResponseMessage(message)
    }

    func onLoadingFailure(_ error: any AppError) {
        self.onStopLoading()
        self.onResponseMessage(error.message)
    }

    // Loading More

    func onStartLoadingMore() {
        isLoadingMore = true
    }

    func onStopLoadingMore() {
        isLoadingMore = false
    }

    func onLoadingMoreFailure(_ error: any AppError) {
        self.onStopLoadingMore()
        self.onToastMessage = error.message
    }

    // Refreshing

    func onStartRefreshing() {
        self.isRefreshing = true
    }

    func onStopRefreshing() {
        self.isRefreshing = false
    }

    func onRefreshingFailure(_ error: any AppError) {
        self.onStopRefreshing()
        self.onResponseMessage(error.message)
    }

    // MARK: - Helpers

    private func onResponseMessage(_ message: String) {
        self.onToastMessage = message
    }
}
