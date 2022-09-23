//
//  LoginRouter.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit

class LoginRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToUserListView(dataSource: UserListDataSource) {
        let userListViewController = UserListBuilder.build(with: dataSource)
        viewController?.navigationController?.viewControllers = [userListViewController]
    }

    func routeToCountryListView(dataSource: CountryListDataSource) {
        push(viewController: CountryListBuilder.build(with: dataSource))
    }

}
