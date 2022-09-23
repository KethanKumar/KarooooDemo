//
//  ViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
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
