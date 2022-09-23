//
//  HeadersBuilder.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

// UIDevice.current.uidd
// UIDevice.current.ipAddress

public class HeadersBuilder {
    
    func commonHeaders() -> [String: String] {
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"]
        return headers
    }
}



//lets capture deviceId, ip address
