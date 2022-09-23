//
//  TaskType.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import UIKit

typealias Parameters = Data

enum TaskType {
    case requestPlain
    case requestParameters(Parameters)
    case requestURL([String: String])
}
