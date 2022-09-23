//
//  Endpoints.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation

enum Endpoint {

    static var DemoBaseurl: URLComponents {
        var urlComponents = URLComponents()
        switch Environment.current {
        case .development:
            urlComponents.scheme = "https"
            urlComponents.host = "jsonplaceholder.typicode.com" //dev
        case .stage:
            urlComponents.scheme = "https"
            urlComponents.host = "jsonplaceholder.typicode.com" //stage
        case .production:
            urlComponents.scheme = "https"
            urlComponents.host = "jsonplaceholder.typicode.com" //prod
        }
        return urlComponents
    }
}
