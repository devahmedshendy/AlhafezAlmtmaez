//
//  SplashScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/11/2023.
//

import UIKit

class SplashScreen: BaseScreen {

    // MARK: - Properties

    private lazy var vm: SplashScreenVM = .init()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vm.onViewDidLoad()
    }
}
