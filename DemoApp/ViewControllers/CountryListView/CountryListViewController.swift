//
//  CountryListViewController.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//


import UIKit

class CountryListViewController: BaseViewController, ViewController {

    typealias ViewModel = CountryListViewModel
    private var viewModel: CountryListViewModel!
    @IBOutlet private weak var countryListTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    func configure(with viewModel: CountryListViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationStyle(with: .clear)
    }
}

private extension CountryListViewController {

    func configure() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(withColor: .black, tapHandler: { [weak self] in
            self?.viewModel.onBack()
        })
        view.reactive.tapGesture().bind(to: self) { me, tap in
            tap.cancelsTouchesInView = false
            me.view.endEditing(true)
        }
        let headerLbl = MediumLabel()
        headerLbl.fontSize = 16.0
        headerLbl.labelColor = .darkGray
        headerLbl.text = "Countries List"
        self.navigationItem.titleView = headerLbl
        countryListTableView.refreshControl = RefreshControl()
        countryListTableView.refreshControl?.addTarget(self, action: #selector(updateTransactions), for: .valueChanged)
        viewModel.isLoading.bind(to: self) {(me, value) in
            if value {
                me.countryListTableView.contentOffset = CGPoint(x: 0, y: -(me.countryListTableView.refreshControl?.frame.size.height ?? 0))
                me.countryListTableView.refreshControl?.beginRefreshing()
            } else {
                me.countryListTableView.refreshControl?.endRefreshing()
            }
        }
        (viewModel.cellViewModels.bind(to: countryListTableView) { [weak self] (item, indexPath, tableView) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            let rowViewModel = item[indexPath.row]
            let rowIdentifier = self.viewModel.cellIdentifier(for: rowViewModel)
            let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)
            (cell as? ConfigurableCell)?.configure(viewModel: rowViewModel)
            return cell
        }).store(in: bag)
        _ = countryListTableView.reactive.selectedRowIndexPath.observeNext { [weak self] in
            self?.viewModel.onRowSelection(atIndex: $0.row)
            self?.countryListTableView.deselectRow(at: $0, animated: true)
        }
        countryListTableView.refreshControl?.tintColor = .clear
        countryListTableView.backgroundColor = UIColor.white
        _ = viewModel.errorToDisplay.observeNext { [weak self] in
            guard let error = $0 else { return }
            self?.showErrorAlertView(error: error)
        }
    }

    @objc func updateTransactions() {
        viewModel.onRefreshCountryList()
    }
}


extension CountryListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onSearch(searchText: searchBar.text ?? "")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.viewModel.onSearch(searchText: searchText)
        })
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onSearch(searchText: searchBar.text ?? "")
    }
}
