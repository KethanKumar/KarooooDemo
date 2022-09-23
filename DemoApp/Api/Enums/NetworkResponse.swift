//
//  NetworkResponse.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//
import SwiftUI

enum NetworkResponse<T> {
    case success(T:Decodable)
    case failure(NetworkError)
}

enum NetworkResponseString {
    case success(String)
    case failure(NetworkError)
}

