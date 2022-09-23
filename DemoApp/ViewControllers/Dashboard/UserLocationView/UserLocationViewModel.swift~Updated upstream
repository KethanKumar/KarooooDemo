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
        self.name = dataSource.userName
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let `self` = self else { return }
            self.latitude.value = Double(self.dataSource.lat.value) ?? location.coordinate.latitude
            self.longitude.value = Double(self.dataSource.long.value) ?? location.coordinate.longitude
            self.hasCordinates.value = true
        }
    }
}

extension UserLocationViewModel {
    func onBack() {
        router.routeBack()
    }
}

