//
//  CreditTransactionCellViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class DemoTableCellViewModel: RowViewModel {

    private let dataSource: DemoTableCellDataSource

    init(dataSource: DemoTableCellDataSource) {
        self.dataSource = dataSource
        configure()
    }
}


private extension DemoTableCellViewModel {
    func configure() {
       
    }
}
