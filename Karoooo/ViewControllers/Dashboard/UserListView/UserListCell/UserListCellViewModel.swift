//
//  UserListCellViewModel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit
import Bond

class UserListCellViewModel: RowViewModel {

    private let userDetail: Observable<UserListDataModel>
    let name = Observable<String?>("")
    let companyName = Observable<String?>("")
    let phone = Observable<String?>("")
    let email = Observable<String?>("")

    init(dataSource: UserListCellDataSource) {
        userDetail = dataSource.userDetail
        configure()
    }
}

private extension UserListCellViewModel {
    func configure() {
        name.value = self.userDetail.value.name
        companyName.value = self.userDetail.value.company?.name
        phone.value = self.userDetail.value.phone
        email.value = self.userDetail.value.email
    }

}
