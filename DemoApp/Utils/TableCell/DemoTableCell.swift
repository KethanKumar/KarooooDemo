//
//  CreditTransactionCell.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class DemoTableCell: UITableViewCell, ConfigurableCell, Reusable {

    private(set) var viewModel: DemoTableCellViewModel!

    func configure(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? DemoTableCellViewModel else { return }
        self.viewModel = viewModel
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func configure() {

    }
}
