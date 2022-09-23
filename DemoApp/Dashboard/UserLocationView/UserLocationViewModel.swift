//
//  UserLocationViewModel.swift
//  UrologyAmerica
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import Bond

class UserLocationViewModel: RoutingViewModel {

    typealias DataSource = UserLocationDataSource
    typealias Router = UserLocationRouter

    private let router: UserLocationRouter
    private let dataSource: UserLocationDataSource

    var latitude = Observable<Double>(0.0)
    var longitude = Observable<Double>(0.0)
    var name = Observable<String>("")
    let hasCordinates = Observable(false)

    required init(dataSource: UserLocationDataSource, router: UserLocationRouter) {
        self.router = router
        self.dataSource = dataSource
        bindFields()
    }
}

// MARK: - Route Actions
private extension UserLocationViewModel {
    func bindFields() {
        self.latitude.value = Double(dataSource.lat.value) ?? 0.0
        self.longitude.value = Double(dataSource.long.value) ?? 0.0
        self.name = dataSource.userName
        self.hasCordinates.value = true
    }
}

extension UserLocationViewModel {
    func onBack() {
        router.routeBack()
    }
}

