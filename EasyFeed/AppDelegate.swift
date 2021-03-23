//
//  AppDelegate.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()

        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
}
