//
//  LoginRouter.swift
//  DCU
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class LoginRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToUserListView(dataSource: UserListDataSource) {
        let userListViewController = UserListBuilder.build(with: dataSource)
        let viewcontrollers: [UIViewController] = [userListViewController]
        viewController?.navigationController?.viewControllers = viewcontrollers
    }

}
