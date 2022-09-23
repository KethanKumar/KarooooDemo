//
//  KeyboardHelper.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
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
