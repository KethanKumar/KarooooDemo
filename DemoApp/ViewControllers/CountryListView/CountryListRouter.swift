//
//  CountryListRouter.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit

class CountryListRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToLogin(dataSource: LoginDataSource) {
        let loginViewController = LoginBuilder.build(with: dataSource)
        viewController?.navigationController?.viewControllers = [loginViewController]
    }
}
