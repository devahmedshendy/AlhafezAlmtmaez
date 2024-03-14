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
        setupTabBarAppearence()
        setupRTLAppearance()
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
                errorLog(error)
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

        let backImage = UIImage(named: "navigate-back-icon")?
            .withTintColor(.navigationTitle)
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

    private func setupTabBarAppearence() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white

        UITabBar.appearance().standardAppearance = appearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        setupTabBarColors(with: appearance.compactInlineLayoutAppearance)
        setupTabBarColors(with: appearance.inlineLayoutAppearance)
        setupTabBarColors(with: appearance.stackedLayoutAppearance)

        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont.avenirArabic_800(size: 14)],
            for: .normal
        )
    }

    private func setupTabBarColors(with appearance: UITabBarItemAppearance) {
        // I thought it should be little ligter to be different than the selected color
        let unselectedColor =  UIColor.tabUnSelected.withAlphaComponent(0.75)
        appearance.normal.iconColor = unselectedColor
        appearance.normal.titleTextAttributes = [
            .foregroundColor : unselectedColor
        ]

        let selectedColor =  UIColor.tabSelected
        appearance.selected.iconColor = selectedColor
        appearance.selected.titleTextAttributes = [
            .foregroundColor : selectedColor
        ]
    }

    private func setupRTLAppearance() {
        // Following line cause this warning:
        /*
         Unable to simultaneously satisfy constraints.
             Probably at least one of the constraints in the following list is one you don't want.
             Try this:
                 (1) look at each constraint and try to figure out which you don't expect;
                 (2) find the code that added the unwanted constraint or constraints and fix it.
         (
             "<NSLayoutConstraint:0x283fc7200 UIView:0x10354ed10.trailing == _UIBackButtonMaskView:0x10354e770.trailing   (active)>",
             "<NSLayoutConstraint:0x283fc77a0 'BIB_Leading_Leading' H:|-(12)-[_UIModernBarButton:0x10354d6d0]   (active, names: '|':_UIButtonBarButton:0x10354c470 )>",
             "<NSLayoutConstraint:0x283fc8190 'Mask_Leading_Leading' H:|-(0)-[_UIBackButtonMaskView:0x10354e770]   (active, names: '|':_UIButtonBarButton:0x10354c470 )>",
             "<NSLayoutConstraint:0x283fc8320 'MaskEV_Leading_BIB_Trailing' H:[_UIModernBarButton:0x10354d6d0]-(0)-[UIView:0x10354ed10]   (active)>"
         )

         Will attempt to recover by breaking constraint
         <NSLayoutConstraint:0x283fc7200 UIView:0x10354ed10.trailing == _UIBackButtonMaskView:0x10354e770.trailing   (active)>

         Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
         The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
         */
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft

        UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
        UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
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
