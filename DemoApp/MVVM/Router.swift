//
//  Router.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation
import UIKit
import SafariServices
import MessageUI


protocol RouterProtocol {
    var viewController: UIViewController? { get }
    init(viewController: UIViewController)
    func routeBack(animate: Bool)
}

extension RouterProtocol {

    func routeBack(animate: Bool = true) {
        viewController?.navigationController?.popViewController(animated: animate)
    }

    func push(viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func pop(to: UIViewController, from: UIViewController) {
        guard let navigationController = from.navigationController else { return }
        navigationController.viewControllers = [to, from]
        navigationController.popViewController(animated: true)
    }

    func routeToDismiss(animated: Bool = true, completion: (() -> Void)?) {
        viewController?.dismiss(animated: animated, completion: completion)
    }

    func presentModally(viewController: UIViewController) {
        viewController.modalPresentationStyle = .overCurrentContext
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
    
}
