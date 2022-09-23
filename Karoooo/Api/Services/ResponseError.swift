//
//  ResponseError.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//


import Foundation

struct APIResponseError: Codable {
    let errorMessage: String?
    let errorCode: Int?
}
