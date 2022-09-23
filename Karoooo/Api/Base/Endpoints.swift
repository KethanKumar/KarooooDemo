//
//  Endpoints.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
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
