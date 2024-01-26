//
//  BaseScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 13/11/2023.
//

import UIKit

class BaseScreen: BaseVC, ViewControllerNavigating {

    // MARK: - Properties

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                spinnerManager.showLoading()
            } else {
                spinnerManager.hideLoading()
            }
        }
    }

    lazy var onNavigatedMessage: String? = nil
    lazy var onToastMessage: String? = nil {
        didSet {
            guard let message = onToastMessage else { return }

            showToast(message)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    private lazy var savedTitle: String = ""

    private(set) lazy var toastManager: ToastManager = .init(superview: self.view)
    private(set) lazy var spinnerManager: SpinnerManager = .init(superview: self.view)
    private(set) lazy var alertManager: UIAlertManager = .init(vc: self)

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        doBringNavigationTitleBack()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeVMBindingsOfViewWillAppear()

        doSaveThenClearNavigationTitle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showNavigatedMessageUnlessNil()
    }

    // MARK: - Actions

    private func doBringNavigationTitleBack() {
        if self.navigationItem.title?.isEmpty ?? true {
            self.navigationItem.title = savedTitle
        }
    }

    private func doSaveThenClearNavigationTitle() {
        savedTitle = self.navigationItem.title ?? ""
        self.navigationItem.title = ""
    }

    // MARK: - Toast

    private func showNavigatedMessageUnlessNil() {
        if let message = onNavigatedMessage {
            toastManager.show(message)
        }
    }

    private func showToast(_ message: String) {
        toastManager.show(message)
    }
}
