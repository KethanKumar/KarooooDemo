//
//  UIDevice+Info.swift
//  DemoApp
//
//  Created by Kethan on 15/09/22.
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

    var ipAddress: String {
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return "" }
        guard let firstAddr = ifaddr else { return "" }

        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                let name = String(cString: interface.ifa_name)
                if ["pdp_ip0", "en0", "en2", "en1"].contains(name) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    let address = String(cString: hostname)
//                    if address.matchesRegex(regex: "(\\d{1,3}\\.){3}\\d{1,3}") {
//                        freeifaddrs(ifaddr)
//                        return address
//                    }
                    return address
                }
            }
        }
        freeifaddrs(ifaddr)
        return ""
    }

    var uidd: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

}

