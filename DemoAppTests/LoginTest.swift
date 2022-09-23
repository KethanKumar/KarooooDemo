//
//  LoginTest.swift
//  DemoAppTests
//
//  Created by Kethan on 23/09/22.
//

import XCTest
@testable import DemoApp

class LoginTest: XCTestCase {
    private lazy var apiService: URLSessionProvider = {
        URLSessionProvider()
    }()

    private lazy var context: Context = {
        let keyValueStorage = KeychainHelper()
        let persistenceController = PersistenceController(keyValueStorage: keyValueStorage)
        let userAuthenticationController = UserAuthenticationController(apiService: apiService, persistenceController: persistenceController, keyValueStorage: keyValueStorage)
        return Context(apiService: apiService, persistenceController: persistenceController, userAuthenticationController: userAuthenticationController)
    }()

    private lazy var userProfile: UserProfileProvider = {
        context.userProfileProvider
    }()

    func testDataSource() {
        let loginDataSource = LoginDataSource(context: context)
        XCTAssert(loginDataSource is LoginDataSource, "invalid DataSource ")
    }

    func testViewContoller() {
        let loginViewController = LoginBuilder.build(with: LoginDataSource(context: context))
        XCTAssert(loginViewController is LoginViewController, "invalid view controller class ")
    }

    func testViewModel() {
        let loginViewController = LoginBuilder.build(with: LoginDataSource(context: context))
        let welcomeRouter = LoginRouter(viewController: loginViewController)
        let welcomeViewDataSource = LoginDataSource(context: context)
        let welcomeViewModel = LoginViewModel(dataSource: welcomeViewDataSource, router: welcomeRouter)
        welcomeViewModel.onLogin()
    }

    func testEmailValidations() {
        let validEmail = "user@mail.com"
        let isValid = validEmail.isEmail
        XCTAssert(isValid == true, "email validation failed")

        let invalidEmail = "email@other"
        let isValidEmail = invalidEmail.isEmail
        XCTAssert(isValidEmail == false, "email validation failed")
    }

    func testPasswordValidations() {
        let validPassword = "Password1234"
        let isValid = validPassword.isValidPassword
        XCTAssert(isValid == true, "password validation failed")

        let invalidPassword = "password"
        let isValidPassword = invalidPassword.isValidPassword
        XCTAssert(isValidPassword == false, "password validation failed")
    }

    func testLogin() {
        XCTAssert((userProfile.userProfile.value?.email ?? "") == "kethankumar87@gmail.com", "Username is valid")
        XCTAssert((userProfile.userProfile.value?.password ?? "") == "Test!123", "Password is valid")
    }

    func testLoginError() {
        XCTAssert((userProfile.userProfile.value?.email ?? "") != "test@gmail.com", "Username is invalid")
        XCTAssert((userProfile.userProfile.value?.password ?? "") != "wqrewfsv", "Password is invalid")

    }
}
