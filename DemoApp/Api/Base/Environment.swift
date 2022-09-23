//
//  Environment.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation

enum Environment {

    case development
    case stage
    case production

    #if ENV_PROD
    static var current: Environment = .production
    #elseif ENV_STG
    static var current: Environment = .stage
    #else
    static var currentEnvironment = UserDefaults.standard.string(forKey: "selectedEnvironment")
    static var current: Environment = EnvironmentHelper().getSelectedEnvironment(current: currentEnvironment ?? "")
    #endif
}

class EnvironmentHelper {
    func getSelectedEnvironment(current: String) -> Environment {
        switch current {
        case "DEV":
            return Environment.development
        case "STAGE":
            return Environment.stage
        case "PROD":
            return Environment.production
        default:
            return Environment.production
        }
    }
}


