//
//  UserProfile.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation
import RealmSwift

class UserProfile: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
}
