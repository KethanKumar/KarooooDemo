//
//  Builder.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import UIKit

protocol Builder {
    associatedtype Built
}

extension Builder where Self.Built: ViewController, Self.Built.ViewModel: RoutingViewModel {

    static func build(with dataSource: Built.ViewModel.DataSource) -> UIViewController {
        let viewController = Built.instantiate()
        let router = Built.ViewModel.Router(viewController: viewController)
        viewController.configure(with: Built.ViewModel(dataSource: dataSource, router: router))
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
}

extension Builder where Self.Built: ViewController, Self.Built.ViewModel: ViewModel {

    static func build(with dataSource: Built.ViewModel.DataSource) -> UIViewController {
        let viewController = Built.instantiate()
        viewController.configure(with: Built.ViewModel(dataSource: dataSource))
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
}
