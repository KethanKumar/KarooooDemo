//
//  UserAuthenticationController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import Bond


class UserAuthenticationController {

    private struct Observer {
        weak var observer: UserAuthenticationControllerObserver?
    }

    typealias RefreshHandler = () -> Void

    private let apiService: URLSessionProvider
    private let persistenceController: PersistenceController
    private let keyValueStorage: KeyValueStorage
    private var isRefreshing: Bool = false
    private var refreshHadlers: [RefreshHandler] = []
    private var observers: [Observer] = []

    private(set) var isSessionRestored = false

    init(apiService: URLSessionProvider, persistenceController: PersistenceController, keyValueStorage: KeyValueStorage) {
        self.apiService = apiService
        self.persistenceController = persistenceController
        self.keyValueStorage = keyValueStorage
    }
}

// MARK: - Observers
extension UserAuthenticationController {

    func updateDataAfterLogin(email: String, password: String) {
        let userAccount = getUserAccountInfo(email: email, password: password)
        persistenceController.storeUserProfile(with: userAccount)
        let loginUserData = UserLoginData(password: password, email: email)

        KeychainManager.saveUserData(data: loginUserData)
    }

    func logout() {
        self.clearAllData()
    }

    func softLogout() {

    }

    func addObserver(_ observer: UserAuthenticationControllerObserver) {
        guard !(observers.contains { $0.observer === observer }) else { return }
        observers.append(Observer(observer: observer))
    }

    func removeObserver(_ observer: UserAuthenticationControllerObserver) {
        observers.removeAll { $0.observer === observer }
    }


    func didUserLogOut() {
        notifyObserver {
            $0.userAuthenticationControllerDidLogout(self)
        }
    }

}

private extension UserAuthenticationController {

    enum KeyValueKeys: String {
        case accessToken
        case username
    }
    
    var username: String? {
        get {
            return keyValueStorage.string(forKey: KeyValueKeys.username.rawValue)
        }
        set {
            if let value = newValue {
                keyValueStorage.set(value, forKey: KeyValueKeys.username.rawValue)
            } else {
                keyValueStorage.removeObject(forKey: KeyValueKeys.username.rawValue)
            }
        }
    }

    func getUserAccountInfo(email: String, password: String) -> Account {
        return Account(email: email, password: password)
    }


    func notifyObserver(_ body: (UserAuthenticationControllerObserver) -> Void) {
        observers.removeAll { $0.observer == nil }
        (observers.compactMap { $0.observer }).forEach(body)
    }

    func deleteAccesToken() {
        keyValueStorage.set("", forKey: KeyValueKeys.accessToken.rawValue)
    }

    func clearAllData() {
        persistenceController.deleteUserProfile()
        notifyObserver {
            $0.userAuthenticationControllerDidLogout(self)
        }
    }

}

extension Optional {
    var description: String {
        if let self = self {
            return "\(self)"
        }
        return ""
    }
}
