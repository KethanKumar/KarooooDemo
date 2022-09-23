//
//  ApplicationNavigator.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class ApplicationNavigator: NSObject {

    private let navigationController = DemoAppNavigationController.navigationController()
    private var window: UIWindow!
    private let context: Context

    init(context: Context) {
        self.context = context
        super.init()
        navigationController.delegate = self
    }

    func start(on window: UIWindow, withLaunchOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.window = window
        window.rootViewController = navigationController
        starBegingFlow()
    }
}

private extension ApplicationNavigator {

    func starBegingFlow() {
        let welcomeViewController = WelcomeBuilder.build(with: WelcomeDataSource(context: context))
        navigationController.viewControllers = [welcomeViewController]
    }
}


extension ApplicationNavigator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let viewControllerNavigationStyle = viewController as? ViewControllerNavigationStyle {
            adjust(navigationBar: navigationController.navigationBar, forStyle: viewControllerNavigationStyle.navigationBarStyle)
        } else {
            adjust(navigationBar: navigationController.navigationBar, forStyle: .clear)
        }
        navigationController.setNeedsStatusBarAppearanceUpdate()
    }

    private func adjust(navigationBar: UINavigationBar, forStyle style: NavigationBarStyle) {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        navigationBar.shadowImage = UIImage()
        let textColor: UIColor
        switch style {
        case .clear:
            textColor = .green
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            navigationBar.barTintColor = .clear
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        case .dark:
            textColor = .black
            if #available(iOS 13.0, *) {
                navigationBar.barTintColor = .systemBackground
            } else {
                navigationBar.barTintColor = .white
            }
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        case .white:
            appearance.configureWithTransparentBackground()
            textColor = .black
            navigationBar.barTintColor = .white
            appearance.backgroundColor = .white
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        case .logo:
            textColor = .green
            appearance.configureWithOpaqueBackground()
            navigationBar.barTintColor = .gray
            appearance.backgroundColor = .gray
            navigationBar.isTranslucent = false
        }
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
        ]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.shadowImage = UIImage()
    }
}
