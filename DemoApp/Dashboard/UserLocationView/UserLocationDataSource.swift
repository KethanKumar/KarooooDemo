//
//  UserLocationDataSource.swift
//  UrologyAmerica
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import Bond

struct UserLocationDataSource: ViewModelDataSource {
    let context: Context
    let lat: Observable<String>
    let long: Observable<String>
    let userName: Observable<String>
}
