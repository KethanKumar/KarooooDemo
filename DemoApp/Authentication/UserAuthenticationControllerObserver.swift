//
//  UserAuthenticationControllerObserver.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation

protocol UserAuthenticationControllerObserver: AnyObject {
    func userAuthenticationController(_ userAuthenticationController: UserAuthenticationController, didLoginWithAccount account: Account)
    func userAuthenticationControllerDidLogout(_ userAuthenticationController: UserAuthenticationController)
    func userAuthenticationController(_ userAuthenticationController: UserAuthenticationController, didFinishSessionWithUsernamme username: String?, firstName: String?, lastName: String?)
}

extension UserAuthenticationControllerObserver {

    func userAuthenticationController(_ userAuthenticationController: UserAuthenticationController, didLoginWithAccount account: Account) {}

    func userAuthenticationControllerDidLogout(_ userAuthenticationController: UserAuthenticationController) {}

    func userAuthenticationController(_ userAuthenticationController: UserAuthenticationController, didFinishSessionWithUsernamme username: String?, firstName: String?, lastName: String?) {}
}
