//
//  BaseViewController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var naigationStyle: NavigationBarStyle = .white

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBar(backgroundColor: .blue)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setUpNavigationStyle(with style: NavigationBarStyle) {
        naigationStyle = style
    }

    func activateSwipeToBackGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    func setStatusBar(backgroundColor: UIColor) {
        let statusBar = UIView(frame: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame)!)
        statusBar.tag = 12345
        statusBar.backgroundColor = backgroundColor
    }
}

extension BaseViewController {
    func showSuccessAlertView(model: AlertViewModel) {
        let heightNotification = UIDevice.current.hasNotch ? 140 : 90
        let notificationView = AlertView(frame: CGRect(x: 0, y: -heightNotification, width: Int(UIScreen.main.bounds.size.width), height: heightNotification ))
        notificationView.configure(with: model, viewController: self)
    }

    func showErrorAlertView(error: ErrorAlertViewModel) {
        let heightNotification = UIDevice.current.hasNotch ? 140 : 90
        let notificationView = ErrorAlertView(frame: CGRect(x: 0, y: -heightNotification, width: Int(UIScreen.main.bounds.size.width), height: heightNotification ))
        notificationView.configure(with: error, viewController: self)
    }
}


extension BaseViewController: ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle {
        return naigationStyle
    }
}
