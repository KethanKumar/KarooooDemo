//
//  NetworkError.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


enum NetworkError: Error {
    case noInternetConnection
    case unknown
    case invalidToken
    case noData
    case timeout
    case decodingError(Error)
}

struct MettaError {
    let title: String
    let message: String
    let code: Int
}
