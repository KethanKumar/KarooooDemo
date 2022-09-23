//
//  UserListViewModel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import UIKit
import Bond

class UserListViewModel: RoutingViewModel {

    typealias DataSource = UserListDataSource
    typealias Router = UserListRouter

    private let router: UserListRouter
    private let dataSource: UserListDataSource
    private let apiService: URLSessionProvider
    var cellRecords = Observable<[DataSourceItem]>([])
    let cellViewModels = Observable<[RowViewModel]>([])
    let usersList = Observable<[UserListDataModel]?>(nil)
    let isLoading = Observable(false)
    let errorToDisplay = Observable<ErrorAlertViewModel?>(nil)

    required init(dataSource: UserListDataSource, router: UserListRouter) {
        self.router = router
        self.dataSource = dataSource
        self.apiService = dataSource.context.apiService
        bindFields()
    }
}

// MARK: - Route Actions

private extension UserListViewModel {
    func bindFields() {
        getUserList()
    }

    func getUserList() {
        self.isLoading.value = true
        apiService.request(type: UserListModel.self, service: GetuserListService.get) { [weak self] response in
            guard let `self` = self else { return }
            self.isLoading.value = false
            switch response {
            case .success(let model):
                guard let modelRes = model as? UserListModel else {
                    self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Demo App", alertMessage: "Something went wrong!")
                    return
                }
                self.usersList.value = modelRes
                self.buildViewModels()
            case .failure(let error):
                self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Demo App", alertMessage: error.localizedDescription)
            }
        }
    }

    func buildViewModels() {
        guard let lists = usersList.value else { return }
        var viewModels = [RowViewModel]()
        for list in lists {
            let userCell = UserListCellDataSource(context: self.dataSource.context, userDetail: Observable(list))
            cellRecords.value.append(userCell)
            viewModels.append(UserListCellViewModel(dataSource: userCell))
        }
        self.cellViewModels.value = viewModels
    }
}

extension UserListViewModel {

    func onRefreshuserList() {
        self.getUserList()
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is UserListCellViewModel:
            return UserListCell.reuseIdentifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    func onRowSelection(atIndex index: Int) {
        guard let userDetail = self.usersList.value?[index] else { return }
        router.routeToUserDetail(dataSource: UserDetailDataSource(context: self.dataSource.context, userDetailModel: Observable(userDetail)))
    }
}
