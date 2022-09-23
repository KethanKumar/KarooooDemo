//
//  Account.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation

struct Account {

    let email: String
    let password: String
    private struct User: Decodable {
        let email: String
    }
}
