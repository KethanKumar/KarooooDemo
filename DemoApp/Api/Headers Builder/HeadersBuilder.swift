//
//  HeadersBuilder.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import UIKit

public class HeadersBuilder {
    
    func commonHeaders() -> [String: String] {
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"]
        return headers
    }
}

