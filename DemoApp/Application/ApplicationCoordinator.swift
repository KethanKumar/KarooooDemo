//
//  ApplicationCoordinator.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import UIKit

class ApplicationCoordinator {

    private lazy var apiService: URLSessionProvider = {
        URLSessionProvider()
    }()

    private lazy var context: Context = {
        let keyValueStorage = KeychainHelper()
        let persistenceController = PersistenceController(keyValueStorage: keyValueStorage)
        let userAuthenticationController = UserAuthenticationController(apiService: apiService, persistenceController: persistenceController, keyValueStorage: keyValueStorage)
        return Context(apiService: apiService, persistenceController: persistenceController, userAuthenticationController: userAuthenticationController)
    }()

    private lazy var applicationNavigator: ApplicationNavigator = {
        ApplicationNavigator(context: context)
    }()

    init() {

    }

    func initialize(on window: UIWindow, _ application: UIApplication, and launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        applicationNavigator.start(on: window, withLaunchOptions: launchOptions)
    }
}

