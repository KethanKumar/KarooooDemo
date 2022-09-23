//
//  ServiceProtocol.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: TaskType { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
