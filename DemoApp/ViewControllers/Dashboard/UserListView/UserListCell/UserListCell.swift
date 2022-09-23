//
//  UserListCell.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import UIKit

class UserListCell: UITableViewCell, ConfigurableCell, Reusable {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!

    private(set) var viewModel: UserListCellViewModel!

    func configure(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? UserListCellViewModel else { return }
        self.viewModel = viewModel
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func configure() {
        viewModel.name.bind(to: nameLabel)
        viewModel.companyName.bind(to: companyLabel)
        viewModel.phone.bind(to: phoneLabel)
        viewModel.email.bind(to: emailLabel)
    }
}
