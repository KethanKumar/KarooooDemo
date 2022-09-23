//
//  ViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation

protocol ViewModel: AnyObject {
    associatedtype DataSource: ViewModelDataSource

    init(dataSource: DataSource)
}

protocol RoutingViewModel: AnyObject {
    associatedtype DataSource: ViewModelDataSource
    associatedtype Router: RouterProtocol

    init(dataSource: DataSource, router: Router)
}
