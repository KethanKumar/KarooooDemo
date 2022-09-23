//
//  URLRequest+Service.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation

extension URLRequest {

  init(service: ServiceProtocol) {
    var urlComponents = URLComponents(service: service)
    var urlQuerys: [URLQueryItem] = []
    self.init(url: urlComponents.url!)
    switch service.task {
    case let .requestURL(parameters):
        if service.method == .get || service.method == .post && service.parametersEncoding == .url {
            for dict in parameters {
                let key = dict.key
                let value = dict.value
                let query = URLQueryItem(name: key, value: value)
                urlQuerys.append(query)
            }
            urlComponents.queryItems = urlQuerys
            self.init(url: urlComponents.url!)
        }
    default:
        print("")
    }

    httpMethod = service.method.rawValue
    service.headers?.forEach { key, value in
      addValue(value, forHTTPHeaderField: key)
    }

    guard case let .requestParameters(parameters) = service.task,
      service.parametersEncoding == .json else { return }
    httpBody = parameters
  }
}
