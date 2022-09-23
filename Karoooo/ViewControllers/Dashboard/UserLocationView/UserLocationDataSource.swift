//
//  UserLocationDataSource.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

struct UserLocationDataSource: ViewModelDataSource {
    let context: Context
    let lat: Observable<String>
    let long: Observable<String>
    let userName: Observable<String>
}
