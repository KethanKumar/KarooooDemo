//
//  UserListCellDataSource.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

struct UserListCellDataSource: ViewModelDataSource, DataSourceItem {
    var context: Context
    let userDetail: Observable<UserListDataModel>
}
