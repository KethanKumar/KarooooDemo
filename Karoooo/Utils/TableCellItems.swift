//
//  TableCellItems.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation

protocol ConfigurableCell {
    func configure(viewModel: RowViewModel)
}

protocol RowViewModel {}
protocol DataSourceItem {}
