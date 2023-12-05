//
//  BaseScrollableFormScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

class BaseScrollableFormScreen: BaseScrollableScreen {

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardObserver.startObserveKeyboardVisibility()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardObserver.stopObserveKeyboardVisibility()
    }
}
