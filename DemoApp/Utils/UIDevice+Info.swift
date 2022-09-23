//
//  UIDevice+Info.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation
import UIKit
import SystemConfiguration

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }

    var isSmallIphone: Bool {
        return  UIScreen.main.bounds.size.height == 568.0
    }

    var isNormalIphone: Bool {
        return  UIScreen.main.bounds.size.height == 667.0
    }

    var isBigIphone: Bool {
        return  UIScreen.main.bounds.size.height > 700.0
    }

    var screenHalfWidth: CGFloat {
        UIScreen.main.bounds.size.width / 2
    }


}

