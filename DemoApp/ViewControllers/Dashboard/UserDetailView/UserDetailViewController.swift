//
//  UserDetailViewController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import UIKit
import Bond

class UserDetailViewController: BaseViewController, ViewController {

    typealias ViewModel = UserDetailViewModel
    private var viewModel: UserDetailViewModel!

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var catchPhraseLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    func configure(with viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

private extension UserDetailViewController {

    func configure() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(withColor: .black, tapHandler: { [weak self] in
            self?.viewModel.onBack()
        })
        let userNameLbl = BoldLabel()
        userNameLbl.fontSize = 16.0
        userNameLbl.labelColor = .darkGray
        userNameLbl.numberOfLines = 0
        viewModel.userName.bind(to: userNameLbl)
        self.navigationItem.titleView = userNameLbl
        navigationItem.rightBarButtonItem = UIBarButtonItem.textBarButtonItem(withTitle: "Location", andTextColor: UIColor.blue) { [weak self] in
            self?.viewModel.onTapLocation()
        }
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.blue], for: .normal)
        viewModel.name.bind(to: nameLabel)
        viewModel.userName.bind(to: userNameLabel)
        viewModel.phone.bind(to: phoneLabel)
        viewModel.email.bind(to: emailLabel)
        viewModel.companyName.bind(to: companyLabel)
        viewModel.catchPhrase.bind(to: catchPhraseLabel)
        viewModel.address.bind(to: addressLabel)
    }
}
