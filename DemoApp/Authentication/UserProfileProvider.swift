//
//  UserProfileProvider.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit
import Bond

class UserProfileProvider {

    private let apiService: URLSessionProvider
    private let persistenceController: PersistenceController
    private let authenticationController: UserAuthenticationController
    let userProfile = Observable<UserProfile?>(nil)

    init(apiService: URLSessionProvider, persistenceController: PersistenceController, authenticationController: UserAuthenticationController) {
        self.apiService = apiService
        self.persistenceController = persistenceController
        self.authenticationController = authenticationController
        _ = persistenceController.userProfile.observeNext { [weak self] in
            self?.userProfile.value = $0
        }
    }

    var userEmail: String? {
        guard let profile = userProfile.value else { return nil }
        return profile.email
    }

    var userPassword: String? {
        return userProfile.value?.password
    }
}
