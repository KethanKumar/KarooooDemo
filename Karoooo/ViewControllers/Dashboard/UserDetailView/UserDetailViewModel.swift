//
//  UserDetailViewModel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

class UserDetailViewModel: RoutingViewModel {

    typealias DataSource = UserDetailDataSource
    typealias Router = UserDetailRouter

    private let router: UserDetailRouter
    private let context: Context
    private let userModel: Observable<UserListDataModel>
    let name = Observable<String?>("")
    let userName = Observable<String?>("")
    let companyName = Observable<String?>("")
    let phone = Observable<String?>("")
    let address = Observable<String?>("")
    let email = Observable<String?>("")
    let catchPhrase = Observable<String?>("")

    required init(dataSource: UserDetailDataSource, router: UserDetailRouter) {
        self.router = router
        self.context = dataSource.context
        self.userModel = dataSource.userDetailModel
        bindFields()
    }
}

// MARK: - Route Actions

private extension UserDetailViewModel {
    func bindFields() {
        name.value = self.userModel.value.name
        userName.value = self.userModel.value.username
        phone.value = self.userModel.value.phone
        email.value = self.userModel.value.email
        companyName.value = self.userModel.value.company?.name
        catchPhrase.value = self.userModel.value.company?.catchPhrase
        address.value = "\(self.userModel.value.address?.street ?? ""), \(self.userModel.value.address?.suite ?? ""), \(self.userModel.value.address?.city ?? ""), \(self.userModel.value.address?.zipcode ?? "")"
    }
}

extension UserDetailViewModel {
    func onBack() {
        router.routeBack()
    }

    func onTapLocation() {
        router.routeToUserLocationView(dataSource: UserLocationDataSource(context: self.context, lat: Observable(self.userModel.value.address?.geo?.lat ?? "0.0"), long: Observable(self.userModel.value.address?.geo?.lng ?? "0.0"), userName: Observable(address.value ?? "")))
    }
}
