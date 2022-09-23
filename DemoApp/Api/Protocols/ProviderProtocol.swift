//
//  ProviderProtocol.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
  func request<T>(type: T.Type, service: ServiceProtocol,
                  completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
