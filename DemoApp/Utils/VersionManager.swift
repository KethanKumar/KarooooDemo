//
//  VersionManager.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation

enum VersionManager {

    static func currentVersion() -> Int {
        let buildString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return Int(buildString) ?? 1
    }

    static func currentVersionString() -> String {
        let buildString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return buildString
    }

    static func isProdVersion() -> Bool {
        let buildIdentifierName = Bundle.main.bundleIdentifier ?? ""
        return !buildIdentifierName.contains("Dev")
    }
}
