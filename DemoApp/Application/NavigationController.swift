//
//  NavigationController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import UIKit

enum NavigationBarStyle {
    case clear
    case dark
    case white
    case logo
}

protocol ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle { get }
}

class DemoAppNavigationController: UINavigationController {

    static func navigationController() -> DemoAppNavigationController {
        let navController = DemoAppNavigationController()
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.tintColor = .green
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
        ]
        navController.navigationBar.titleTextAttributes = textAttributes
        return navController
    }

    func viewController(before viewController: UIViewController) -> UIViewController? {
        var previous: UIViewController?
        for nextViewController in viewControllers {
            if nextViewController == viewController {
                return previous
            }
            previous = nextViewController
        }
        return nil
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }

    func adjustNavigationBar(forViewController viewController: UIViewController) {
        delegate?.navigationController?(self, willShow: viewController, animated: true)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension DemoAppNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool { true }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}

extension DemoAppNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
