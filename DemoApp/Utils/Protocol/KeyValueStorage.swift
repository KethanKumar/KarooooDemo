//
//  KeyValueStorage.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation

protocol KeyValueStorage {

    func string(forKey defaultName: String) -> String?
    func double(forKey defaultName: String) -> Double
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Double, forKey defaultName: String)
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
}
