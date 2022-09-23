//
//  ProviderProtocol.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation

protocol ProviderProtocol {
  func request<T>(type: T.Type, service: ServiceProtocol,
                  completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
