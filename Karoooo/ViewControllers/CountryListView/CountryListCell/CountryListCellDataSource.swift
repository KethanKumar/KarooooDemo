//
//  CountryListCellDataSource.swift
///  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

struct CountryListCellDataSource: ViewModelDataSource, DataSourceItem {
    var context: Context
    let countryName: Observable<String>
}
