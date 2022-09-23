//
//  UserListCellDataSource.swift
//  Oyster-Native-App
//
//  Created by Kethan Kumar on 17/04/21.
//

import Foundation
import Bond

struct UserListCellDataSource: ViewModelDataSource, DataSourceItem {
    var context: Context
    let userDetail: Observable<UserListDataModel>
}
