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

    var timer: Timer?

    func configure(with viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        startTimer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setUpNavigationStyle(with: .clear)
    }

    deinit {
        timer?.invalidate()
    }
}

private extension UserDetailViewController {

    func configure() {

    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: viewModel.timeInterval.value, target: self, selector: #selector(onRegister), userInfo: nil, repeats: false)
    }

    @objc func onRegister() {
        self.viewModel.routeToLogin()
    }
}
