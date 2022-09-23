//
// LoginViewModel.swift
//  DCU
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import UIKit
import ReactiveKit
import Bond

class LoginViewModel: RoutingViewModel {

    typealias DataSource = LoginDataSource
    typealias Router = LoginRouter

    private let router: LoginRouter
    private let context: Context
    private let userProfile: UserProfileProvider
    let canContinue = Observable(false)
    let isLoading = Observable<Bool>(false)
    let email = Observable<String?>("kethankumar87@gmail.com")
    let password = Observable<String?>("Test!123")
    let isEmailInvalid = Observable<Bool>(false)
    let isPasswordInvalid = Observable<Bool>(false)
    let loginSuccess = Observable(false)
    let errorToDisplay = Observable<ErrorAlertViewModel?>(nil)

    required init(dataSource: LoginDataSource, router: LoginRouter) {
        self.router = router
        self.context = dataSource.context
        self.userProfile = dataSource.context.userProfileProvider
        bindFields()
    }
}

private extension LoginViewModel {
    func bindFields() {
        _ = canContinue.bind(signal: combineLatest(email.toSignal(), password.toSignal()).map {
            guard let email = $0, let password = $1 else { return false }
            return !email.isEmpty && !password.isEmpty 
        })
    }

    func validateErrors() -> Bool {
        isEmailInvalid.value = !(email.value ?? "").isEmail
        isPasswordInvalid.value = !(password.value ?? "").isValidPassword
        if !(email.value ?? "").isEmail {
            self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Error", alertMessage: "Invalid Email")
            return false
        }
        if !(password.value ?? "").isValidPassword {
            self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Error", alertMessage: "Invalid Password")
            return false
        }
        if userProfile.userEmail == self.email.value && userProfile.userPassword == self.password.value {
            return !isEmailInvalid.value && !isPasswordInvalid.value
        } else {
            self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Error", alertMessage: "Username or Password doesn't match")
           return false
        }

    }
}


extension LoginViewModel {

    func clearFields() {
        self.email.value = ""
        self.password.value = ""
    }

    func onLogin() {
        if validateErrors() {
            self.routeToDashboard()
        }
    }


    func routeToDashboard() {
        router.routeToUserListView(dataSource: UserListDataSource(context: self.context))
    }

    func onTapregister() {

    }

    func onForgotPassword() {

    }

    func loginWithfaceId() {
        BiometricManager.main.authenticate(delegate: self)
    }
}

extension LoginViewModel: BioMetricStatusDelegate {
    func biometricAuthentication(isSuccessful: Bool) {
        if isSuccessful {
            DispatchQueue.main.async {
                self.onLogin()
            }
        }
    }
}
