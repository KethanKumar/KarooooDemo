//
//  UserListRouter.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit

class UserListRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToUserDetail(dataSource: UserDetailDataSource) {
        push(viewController: UserDetailBuilder.build(with: dataSource))
    }

    func routeToLogin(dataSource: LoginDataSource) {
        let loginView = LoginBuilder.build(with: dataSource)
        viewController?.navigationController?.viewControllers = [loginView]
    }
}
