//
//  TaskType.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

typealias Parameters = Data

enum TaskType {
    case requestPlain
    case requestParameters(Parameters)
    case requestURL([String: String])
}
