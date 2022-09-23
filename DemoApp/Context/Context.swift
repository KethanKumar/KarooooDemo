//
//  Context.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import Foundation

final class Context {

    private (set) var apiService: URLSessionProvider
    private let persistenceController: PersistenceController
    let userAuthenticationController: UserAuthenticationController
    let userProfileProvider: UserProfileProvider

    init(apiService: URLSessionProvider,
         persistenceController: PersistenceController,
         userAuthenticationController: UserAuthenticationController) {
        self.apiService = apiService
        self.persistenceController = persistenceController
        self.userAuthenticationController = userAuthenticationController
        self.userProfileProvider = UserProfileProvider(apiService: apiService,
                                                       persistenceController: persistenceController,
                                                       authenticationController: userAuthenticationController)
    }
}
