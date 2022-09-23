//
//  CountryListDataSource.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

struct CountryListDataSource: ViewModelDataSource {
    let context: Context
    var selectedCountry: Observable<String?>
}
