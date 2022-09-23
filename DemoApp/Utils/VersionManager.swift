//
//  VersionManager.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
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
