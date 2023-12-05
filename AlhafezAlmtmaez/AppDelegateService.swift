//
//  AppDelegateService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import UIKit
import UserNotificationsUI

final class AppDelegateService: BaseService {

    // MARK: - Logic

    func onDidFinishLaunching(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        setupKeychainIfNeeded()
        setupNotification(application: application)

        setupScreenNavigationBarAppearance()
    }

    // MARK: - Setup

    private func setupKeychainIfNeeded() {
        let defaults = UserDefaultsService.shared

        if defaults.isFirstTimeRun {
            let keychain = KeychainStorage()

            do {
                try keychain.clear()
                defaults.setNoMoreFirstTimeRun()
            } catch {
                print(error)
            }
        }
    }

    private func setupNotification(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
    }

    private func setupScreenNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()

        appearance.backgroundEffect = nil
        appearance.backgroundImage = .init()
        appearance.backgroundColor = .clear

        appearance.titleTextAttributes = .navigationTitle
        appearance.largeTitleTextAttributes = .navigationTitle

        let backImage = UIImage(
            systemName: "chevron.backward.circle"
        )?.withTintColor(.navigationTitle)

        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        UINavigationBar.appearance(
            whenContainedInInstancesOf: [ScreenNavigationController.self]
        ).standardAppearance = appearance

        UINavigationBar.appearance(
            whenContainedInInstancesOf: [ScreenNavigationController.self]
        ).scrollEdgeAppearance = appearance

        UINavigationBar.appearance(
            whenContainedInInstancesOf: [ScreenNavigationController.self]
        ).tintColor = .navigationTitle
    }
}

//// MARK: - MessagingDelegate
//
//extension AppDelegateService: MessagingDelegate {
//    func messaging(
//        _ messaging: Messaging,
//        didReceiveRegistrationToken fcmToken: String?
//    ) {
//        if let fcmToken = fcmToken {
//            print("fcmToken: " + fcmToken)
//            //            updateNotification(
//            //                isOn: Helper.getIsNotificationOn(),
//            //                mobileToken: fcmToken,
//            //                onFinishLoading: { errorAPI, mess in
//            //                    if errorAPI {
//            //                        Logger.error(mess!)
//            //                    }
//            //                }
//            //            )
//        }
//    }
//}
//
extension AppDelegateService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print(messageID)
//        }

        return [.sound, .badge]
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        let userInfo = response.notification.request.content.userInfo

//        if let messageID = userInfo[gcmMessageIDKey] {
//            Logger.debug("Message ID: \(messageID)")
//        }

//        print(userInfo)
    }
}
