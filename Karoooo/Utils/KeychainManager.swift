//
//  KeychainManager.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//


import SwiftKeychainWrapper

enum TokenType: String {
    case accessToken
    case refreshToken
}

enum Keys {

}

struct UserLoginData {
    let password: String
    let email: String
}

class KeychainManager {


    static func saveUserData(data: UserLoginData) {
        clearLoginData()
        KeychainWrapper.standard.set(data.email, forKey: "email")
        KeychainWrapper.standard.set(data.password, forKey: "password")
    }

    static func getPassword() -> String? {
        guard let data = KeychainWrapper.standard.data(forKey: "password") else { return nil }
        let value = String(decoding: data, as: UTF8.self)
        return value
    }

    static func getEmail() -> String? {
        guard let data = KeychainWrapper.standard.data(forKey: "email") else { return nil }
        let value = String(decoding: data, as: UTF8.self)
        return value
    }

    static func clearLoginData() {

    }

    static func clearUserData() {
        KeychainWrapper.standard.removeObject(forKey: "password")
        KeychainWrapper.standard.removeObject(forKey: "email")
    }

}
