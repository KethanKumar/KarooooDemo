//
//  UserListViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import UIKit
import Bond

class UserListViewModel: RoutingViewModel {

    typealias DataSource = UserListDataSource
    typealias Router = UserListRouter

    private let router: UserListRouter
    private let context: Context
    var timeInterval = Observable<Double>(2)
    private let authenticationController: UserAuthenticationController

    required init(dataSource: UserListDataSource, router: UserListRouter) {
        self.router = router
        self.context = dataSource.context
        self.authenticationController = dataSource.context.userAuthenticationController
        bindFields()
    }
}

// MARK: - Route Actions

private extension UserListViewModel {
    func bindFields() {
        authenticationController.updateDataAfterLogin(email: "kethankumar87@gmail.com", password: "Test!123")
    }
}

extension UserListViewModel {
    func routeToLogin() {
        router.routeToLoginView(dataSource: LoginDataSource(context: self.context))
//        router.routeToIntroView(dataSource: IntroDataSource(context: self.context))
    }
}
