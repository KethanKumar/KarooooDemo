//
//  KeyboardHelper.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation
import UIKit

class KeyboardHelper {

    static let sharedInstance = KeyboardHelper()

    var activeTextField: UITextField?

    func setActiveTextField(textField: UITextField) {
        activeTextField = textField
    }

    func getActiveTextField() -> UITextField? {
        return activeTextField
    }

    func clear() {
        activeTextField = nil
    }
}
