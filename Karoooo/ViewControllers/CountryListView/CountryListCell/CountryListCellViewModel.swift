//
//  CountryListCellViewModel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit
import Bond

class CountryListCellViewModel: RowViewModel {

    private let dataSource: CountryListCellDataSource
    let name = Observable<String?>("")

    init(dataSource: CountryListCellDataSource) {
        self.dataSource = dataSource
        configure()
    }
}

private extension CountryListCellViewModel {
    func configure() {
        name.value = self.dataSource.countryName.value
    }

}
