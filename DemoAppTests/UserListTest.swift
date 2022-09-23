//
//  UserListTest.swift
//  DemoAppTests
//
//  Created by Kethan on 23/09/22.
//

import XCTest
@testable import DemoApp

class UserListTest: XCTestCase {
    private lazy var apiService: URLSessionProvider = {
        URLSessionProvider()
    }()

    private lazy var context: Context = {
        let keyValueStorage = KeychainHelper()
        let persistenceController = PersistenceController(keyValueStorage: keyValueStorage)
        let userAuthenticationController = UserAuthenticationController(apiService: apiService, persistenceController: persistenceController, keyValueStorage: keyValueStorage)
        return Context(apiService: apiService, persistenceController: persistenceController, userAuthenticationController: userAuthenticationController)
    }()

    func testDataSource() {
        let userListDataSource = UserListDataSource(context: context)
        XCTAssert(userListDataSource is UserListDataSource, "invalid DataSource ")
    }

    func testViewContoller() {
        let userListViewController = UserListBuilder.build(with: UserListDataSource(context: context))
        XCTAssert(userListViewController is UserListViewController, "invalid view controller class ")
    }

    func testViewModel() {
        let userListViewController = UserListBuilder.build(with: UserListDataSource(context: context))
        let userListRouter = UserListRouter(viewController: userListViewController)
        let userListDataSource = UserListDataSource(context: context)
        let userListViewModel = UserListViewModel(dataSource: userListDataSource, router: userListRouter)
        userListViewModel.onRefreshuserList()
    }

    func testUserListService() {
        apiService.request(type: UserListModel.self, service: GetuserListService.get) { (response) in
            switch response {
            case .success(let model):
                guard let modelRes = model as? UserListModel else {
                    XCTFail()
                    return
                }
                XCTAssert(modelRes.count > 0, "Fetched user list successfully")
            case .failure:
                XCTFail()
            }
        }
    }
}
