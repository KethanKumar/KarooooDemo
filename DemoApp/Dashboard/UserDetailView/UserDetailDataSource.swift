//
//  UserDetailDataSource.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import Bond

struct UserDetailDataSource: ViewModelDataSource {
    let context: Context
    let userDetailModel: Observable<UserListDataModel>
}
