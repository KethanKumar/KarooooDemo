//
//  UserListViewController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//


import UIKit

class UserListViewController: BaseViewController, ViewController {

    typealias ViewModel = UserListViewModel
    private var viewModel: UserListViewModel!
    @IBOutlet private weak var userListTableView: UITableView!

    func configure(with viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

private extension UserListViewController {

    func configure() {
        userListTableView.refreshControl = RefreshControl()
        userListTableView.refreshControl?.addTarget(self, action: #selector(updateTransactions), for: .valueChanged)
        viewModel.isLoading.bind(to: self) {(me, value) in
            if value {
                me.userListTableView.contentOffset = CGPoint(x: 0, y: -(me.userListTableView.refreshControl?.frame.size.height ?? 0))
                me.userListTableView.refreshControl?.beginRefreshing()
            } else {
                me.userListTableView.refreshControl?.endRefreshing()
            }
        }
        (viewModel.cellViewModels.bind(to: userListTableView) { [weak self] (item, indexPath, tableView) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            let rowViewModel = item[indexPath.row]
            let rowIdentifier = self.viewModel.cellIdentifier(for: rowViewModel)
            let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)
            (cell as? ConfigurableCell)?.configure(viewModel: rowViewModel)
            return cell
        }).store(in: bag)
        _ = userListTableView.reactive.selectedRowIndexPath.observeNext { [weak self] in
            self?.viewModel.onRowSelection(atIndex: $0.row)
            self?.userListTableView.deselectRow(at: $0, animated: true)
        }
        userListTableView.refreshControl?.tintColor = .clear
        userListTableView.backgroundColor = UIColor.white
        _ = viewModel.errorToDisplay.observeNext { [weak self] in
            guard let error = $0 else { return }
            self?.showErrorAlertView(error: error)
        }
    }

    @objc func updateTransactions() {
        viewModel.onRefreshuserList()
    }
}
