//
//  UserProfile.swift
//  DCU
//
//  Created by Kethan on 24/02/22.
//

import Foundation
import RealmSwift

class UserProfile: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
}
