//
//  ResponseError.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation

struct APIResponseError: Codable {
    let errorMessage: String?
    let errorCode: Int?
}
