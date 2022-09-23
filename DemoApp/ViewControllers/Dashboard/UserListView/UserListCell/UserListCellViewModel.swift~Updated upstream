//
//  UserListCellViewModel.swift
//  Oyster-Native-App
//
//  Created by Kethan Kumar on 17/04/21.
//  Copyright © 2020 Oyster. All rights reserved.
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
