//
//  String+Types.swift
//  DemoApp
//
//  Created by Kethan on 22/09/22.
//

import Foundation

extension String {

    func matchesRegex(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }

    var isEmail: Bool {
        let regexString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return matchesRegex(regex: regexString)
    }

    var isValidPassword: Bool {
        let numbersRule = ".*[0-9].*$"
        let lowerCaseRule = ".*[a-z].*$"
        let capitalLetterRule = ".*[A-Z].*$"
        let lenghtRule = "^.{8,}$"

        return matchesRegex(regex: numbersRule) && matchesRegex(regex: lowerCaseRule) && matchesRegex(regex: capitalLetterRule) && matchesRegex(regex: lenghtRule)
    }
}
