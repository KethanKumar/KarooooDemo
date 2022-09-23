//
//  UserDetailRouter.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
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
