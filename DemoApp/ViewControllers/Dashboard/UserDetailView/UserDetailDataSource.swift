//
//  UserDetailDataSource.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

struct UserDetailDataSource: ViewModelDataSource {
    let context: Context
    let userDetailModel: Observable<UserListDataModel>
}
