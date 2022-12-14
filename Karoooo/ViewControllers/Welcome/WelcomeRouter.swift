//
//  WelcomeRouter.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit

class WelcomeRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToLoginView(dataSource: LoginDataSource) {
        push(viewController: LoginBuilder.build(with: dataSource))
    }
}
