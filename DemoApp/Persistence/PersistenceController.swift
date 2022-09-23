//
//  PersistenceController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation
import ReactiveKit
import Bond
import RealmSwift

class PersistenceController {

    private let keyValueStorage: KeyValueStorage
    private let database: Realm
    private static let databaseEncryptionStorageKey = "dbKey"
    private static func generateDatabaseEncryptionKey() -> Data {
        let bytes = (0 ..< 64).map { _ in UInt8.random(in: 0..<255) }
        return bytes.withUnsafeBufferPointer { (buffer: UnsafeBufferPointer<UInt8>) -> Data in
            Data(buffer: buffer)
        }
    }

    private(set) var userProfile = Observable<UserProfile?>(nil)

    init(keyValueStorage: KeyValueStorage) {
        self.keyValueStorage = keyValueStorage
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = UInt64(VersionManager.currentVersion())
        if let databaseEncryptionKey = keyValueStorage.data(forKey: PersistenceController.databaseEncryptionStorageKey) {
            configuration.encryptionKey = databaseEncryptionKey
        } else {
            let newKey = PersistenceController.generateDatabaseEncryptionKey()
            keyValueStorage.set(newKey, forKey: PersistenceController.databaseEncryptionStorageKey)
            configuration.encryptionKey = newKey
        }
        do {
            database = try Realm(configuration: configuration)
            loadObjects()
        } catch {
            do {
                configuration.deleteRealmIfMigrationNeeded = true
                database = try Realm(configuration: configuration)
                loadObjects()
            } catch {
                fatalError("Unable to load database: \(error)")
            }
        }
    }

    func updateUserProfileInfoWith(account: UserInformation) {
        self.userProfile.value = userProfile.value
    }

    func deleteUserProfile() {
        guard let userProfile = userProfile.value else { return }
        do {
            try database.write {
                database.delete(userProfile)
                self.userProfile.value = nil
            }
            //deletePayCards()
        } catch {
            fatalError("Unable to save in database: \(error)")
        }
    }
}

// swiftlint:disable all
extension PersistenceController {
    func storeUserProfile(with account: Account) {
        let userProfile = UserProfile()
        userProfile.password = account.password
        userProfile.email = account.email
        do {
            try database.write {
                database.delete(database.objects(UserProfile.self))
                database.add(userProfile)
            }
            self.userProfile.value = userProfile
        } catch {
            fatalError("Unable to save in database: \(error)")
        }
    }
}


private extension PersistenceController {

    func loadObjects() {
        fetchUserProfile()
    }

    func fetchUserProfile() {
        userProfile = Observable(database.objects(UserProfile.self).first)
    }
}
