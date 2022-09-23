//
//  WelcomeScreenTest.swift
//  DemoApp
//
//  Created by Kethan on 05/09/22.
//

import XCTest
@testable import DemoApp

class WelcomeScreenTest: XCTestCase {

    private lazy var apiService: URLSessionProvider = {
        URLSessionProvider()
    }()

    private lazy var context: Context = {
        let keyValueStorage = KeychainHelper()
        let persistenceController = PersistenceController(keyValueStorage: keyValueStorage)
        let userAuthenticationController = UserAuthenticationController(apiService: apiService, persistenceController: persistenceController, keyValueStorage: keyValueStorage)
        return Context(apiService: apiService, persistenceController: persistenceController, userAuthenticationController: userAuthenticationController)
    }()

    func testDataSource() {
        let welcomeViewDataSource = WelcomeDataSource(context: context)
        XCTAssert(welcomeViewDataSource is WelcomeDataSource, "invalid DataSource ")
    }

    func testViewContoller() {
        let welcomeViewController = WelcomeBuilder.build(with: WelcomeDataSource(context: context))
        XCTAssert(welcomeViewController is WelcomeViewController, "invalid view controller class ")
    }

    func testViewModel() {
        let welcomeViewController = WelcomeBuilder.build(with: WelcomeDataSource(context: context))
        let welcomeRouter = WelcomeRouter(viewController: welcomeViewController)
        let welcomeViewDataSource = WelcomeDataSource(context: context)
        let welcomeViewModel = WelcomeViewModel(dataSource: welcomeViewDataSource, router: welcomeRouter)
        welcomeViewModel.test()
    }
}
