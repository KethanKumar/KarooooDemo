//
//  CountryListCell.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit

class CountryListCell: UITableViewCell, ConfigurableCell, Reusable {

    @IBOutlet private weak var countryNameLbl: UILabel!

    private(set) var viewModel: CountryListCellViewModel!

    func configure(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? CountryListCellViewModel else { return }
        self.viewModel = viewModel
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func configure() {
        viewModel.name.bind(to: countryNameLbl)
    }
}
