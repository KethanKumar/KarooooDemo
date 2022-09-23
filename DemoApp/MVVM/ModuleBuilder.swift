//
//  ModuleBuilder.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
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
