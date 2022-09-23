//
//  WelcomeViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import UIKit
import Bond

class WelcomeViewModel: RoutingViewModel {

    typealias DataSource = WelcomeDataSource
    typealias Router = WelcomeRouter

    private let router: WelcomeRouter
    private let context: Context
    var timeInterval = Observable<Double>(2)
    private let authenticationController: UserAuthenticationController

    required init(dataSource: WelcomeDataSource, router: WelcomeRouter) {
        self.router = router
        self.context = dataSource.context
        self.authenticationController = dataSource.context.userAuthenticationController
        bindFields()
    }
}

// MARK: - Route Actions

private extension WelcomeViewModel {
    func bindFields() {
        authenticationController.updateDataAfterLogin(email: "kethankumar87@gmail.com", password: "Test!123")
    }
}

extension WelcomeViewModel {
    func routeToLogin() {
        router.routeToLoginView(dataSource: LoginDataSource(context: self.context))
//        router.routeToIntroView(dataSource: IntroDataSource(context: self.context))
    }
}
