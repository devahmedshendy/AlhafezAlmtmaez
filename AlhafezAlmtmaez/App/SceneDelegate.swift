//
//  SceneDelegate.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/11/2023.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    private lazy var subscription: AnyCancellable? = nil
    private lazy var sessionService: UserSessionService = .init()

    // MARK: - LifeCycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = scene as? UIWindowScene else { return }

        self.setupWindow(from: windowScene)
        self.setupSessionBindings()
    }

    // MARK: - Bindings

    private func setupSessionBindings() {
        subscription = sessionService
            .$state
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .startup: return self.onStartupSession()
                case .active: return self.onActiveSession()
                case .inactive: return self.onInactiveSession()
                }
            }
    }

    private func onStartupSession() {
        debugLog(Self.self, #function)
    }

    private func onActiveSession() {
        debugLog(Self.self, #function)
        setRootViewController(to: MainTabBarController())
    }

    private func onInactiveSession() {
        debugLog(Self.self, #function)
        setRootViewController(
            to: ScreenNavigationController(
                rootViewController: SignInScreen()
            )
        )
    }

    // MARK: - Helpers

    private func setRootViewController(to vc: UIViewController) {
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}

// MARK: - Setup

extension SceneDelegate {
    private func setupWindow(from scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        self.setRootViewController(to: SplashScreen())
    }
}
