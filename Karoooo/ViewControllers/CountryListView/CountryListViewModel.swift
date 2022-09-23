//
//  CountryListViewModel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22..
//

import Foundation
import Bond

class CountryListViewModel: RoutingViewModel {

    typealias DataSource = CountryListDataSource
    typealias Router = CountryListRouter

    private let router: CountryListRouter
    private let dataSource: CountryListDataSource
    private let apiService: URLSessionProvider
    var cellRecords = Observable<[DataSourceItem]>([])
    let cellViewModels = Observable<[RowViewModel]>([])
    let countrysList = Observable<[GetListOfCountriesDataModel]?>(nil)
    var filterList = [GetListOfCountriesDataModel]()
    let isLoading = Observable(false)
    let errorToDisplay = Observable<ErrorAlertViewModel?>(nil)

    required init(dataSource: CountryListDataSource, router: CountryListRouter) {
        self.router = router
        self.dataSource = dataSource
        self.apiService = dataSource.context.apiService
        bindFields()
    }
}

// MARK: - Route Actions

private extension CountryListViewModel {
    func bindFields() {
        getCountryList()
    }

    func getCountryList() {
        self.isLoading.value = true
        apiService.request(type: GetListOfCountriesModel.self, service: GetListOfCountriesService.get) { [weak self] response in
            guard let `self` = self else { return }
            self.isLoading.value = false
            switch response {
            case .success(let model):
                guard let modelRes = model as? GetListOfCountriesModel else {
                    self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Demo App", alertMessage: "Something went wrong!")
                    return
                }
                self.countrysList.value = modelRes.sorted(by: { val1, val2 in
                    return (val1.name?.common ?? "") < (val2.name?.common ?? "")
                })
                self.filterList = self.countrysList.value ?? []
                self.buildViewModels()
            case .failure(let error):
                self.errorToDisplay.value = ErrorAlertViewModel(alertTitle: "Demo App", alertMessage: error.localizedDescription)
            }
        }
    }

    func buildViewModels() {
        var viewModels = [RowViewModel]()
        for list in filterList {
            let CountryCell = CountryListCellDataSource(context: self.dataSource.context, countryName: Observable(list.name?.common ?? ""))
            cellRecords.value.append(CountryCell)
            viewModels.append(CountryListCellViewModel(dataSource: CountryCell))
        }
        self.cellViewModels.value = viewModels
    }
}

extension CountryListViewModel {

    func onBack() {
        router.routeBack()
    }

    func onRefreshCountryList() {
        self.getCountryList()
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is CountryListCellViewModel:
            return CountryListCell.reuseIdentifier
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    func onRowSelection(atIndex index: Int) {
        guard let country = filterList[index].name?.common else { return }
        self.dataSource.selectedCountry.value = country
        onBack()
    }

    func onSearch(searchText: String) {
        filterList = (searchText.count > 0 ? countrysList.value?.filter { ($0.name?.common ?? "").hasPrefix(searchText)} : countrysList.value) ?? []
        self.buildViewModels()
    }
}
