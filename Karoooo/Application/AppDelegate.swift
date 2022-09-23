//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchScreenView: UIView?
    let coordinator = ApplicationCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        coordinator.initialize(on: window!, application, and: launchOptions)
        return true
    }
}
