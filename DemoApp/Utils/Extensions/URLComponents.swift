//
//  URLComponents.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation

extension URLComponents {

    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
    }
}
