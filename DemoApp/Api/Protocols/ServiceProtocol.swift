//
//  ServiceProtocol.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
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
