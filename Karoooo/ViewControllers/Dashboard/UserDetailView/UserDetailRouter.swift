//
//  UserDetailRouter.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit

class UserDetailRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToUserLocationView(dataSource: UserLocationDataSource) {
        push(viewController: UserLocationBuilder.build(with: dataSource))
    }
}
