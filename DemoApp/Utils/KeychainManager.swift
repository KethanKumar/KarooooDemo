//
//  KeychainManager.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
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

    static func saveToken(type: TokenType, token: String) -> Bool {
        _ = deleteToken(type: type)
        let saveSucceed = KeychainWrapper.standard.set(token, forKey: type.rawValue)
        return saveSucceed
    }

    static func getValue(for type: TokenType) -> String? {
        guard let data = KeychainWrapper.standard.data(forKey: type.rawValue) else { return nil }
        let value = String(decoding: data, as: UTF8.self)
        return value
    }

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
        _ = deleteToken(type: .accessToken)
    }

    static func clearUserData() {
        KeychainWrapper.standard.removeObject(forKey: "password")
        KeychainWrapper.standard.removeObject(forKey: "email")
    }

    private static func deleteToken(type: TokenType) -> Bool {
        let deleteSucceed = KeychainWrapper.standard.removeObject(forKey: type.rawValue)
        return deleteSucceed
    }

    private static func delete(key: String) -> Bool {
        let deleteSucceed = KeychainWrapper.standard.removeObject(forKey: key)
        return deleteSucceed
    }
}
