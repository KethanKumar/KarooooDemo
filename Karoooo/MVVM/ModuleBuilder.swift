//
//  ModuleBuilder.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//


import UIKit

public protocol ModuleBuilder: AnyObject {

    func build() -> UIViewController
    func customBuilder() -> UIViewController?
}

public extension ModuleBuilder {

    func customBuilder() -> UIViewController? {
        return nil
    }
}
