//
//  UserAuthenticationControllerObserver.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
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
