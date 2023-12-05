//
//  BaseVC.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import UIKit
import Combine

class BaseVC: UIViewController,
              KeyboardObserverDelegate {

    // MARK: - Properties

    lazy var viewWillAppearBindings: Set<AnyCancellable> = []
    lazy var viewDidLoadBindings: Set<AnyCancellable> = []

    private(set) lazy var keyboardObserver: KeyboardObserver = .init()

    // MARK: - LifeCycle

    deinit {
        disposeVMBindingsOfViewDidLoad()
        disposeVMBindingsOfViewWillAppear()

        print(Self.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVMBindingsOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardObserver.delegate = self

        setupVMBindingsOnViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardObserver.delegate = nil

        disposeVMBindingsOfViewWillAppear()
    }

    // MARK: - Bindings Setup

    func setupVMBindingsOnViewDidLoad() {
        // This should be overriden by subclasses
    }

    func disposeVMBindingsOfViewDidLoad() {
        viewDidLoadBindings.forEach { $0.cancel() }
        viewDidLoadBindings.removeAll()
    }

    func setupVMBindingsOnViewWillAppear() {
        // This should be overriden by subclasses
    }

    func disposeVMBindingsOfViewWillAppear() {
        viewWillAppearBindings.forEach { $0.cancel() }
        viewWillAppearBindings.removeAll()
    }

    // MARK: - Gestures

    func setupTapGesture(cancelsTouchesInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onTapGestureHappened)
        )

        tapGesture.cancelsTouchesInView = cancelsTouchesInView

        view.addGestureRecognizer(tapGesture)
    }

    @objc private func onTapGestureHappened() {
//        singleOverlayManager.onHideAllOverlays(
//            forControllerID: self.objIdentifier
//        )
        view.endEditing(true)
    }

    // MARK: - KeyboardObserverDelegate

    func onKeyboardBecomesVisible() {
//        singleOverlayManager.onKeyboardBecomesVisible(
//            forController: self.objIdentifier
//        )
    }

    func onKeyboardHeightChange(_ keyboardHeight: CGFloat) {
        assertionFailure("This should be overriden by subclasses")
    }

    // MARK: - Helpers

    // TODO: This looks a heavy logic, or..?
    func findFirstResponder(inView view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.isFirstResponder {
                return subview
            }

            if let subview = findFirstResponder(inView: subview) {
                return subview
            }
        }

        return nil
    }
}
