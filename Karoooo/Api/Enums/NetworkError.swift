//
//  NetworkError.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
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
