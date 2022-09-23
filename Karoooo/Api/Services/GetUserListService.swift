//
//  GetUserListService.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

import Foundation

struct UserListDataModel: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias UserListModel = [UserListDataModel]



enum GetuserListService: ServiceProtocol {

    case get

    var baseURL: URL {
        guard let url = Endpoint.DemoBaseurl.url else { fatalError("BaseURL is nil") }
        return url
    }

    var path: String {
        return "/users"
    }

    var method: HTTPMethod {
        return .get
    }

    var task: TaskType {
        return .requestPlain
    }

    var headers: Headers? {
        return HeadersBuilder().commonHeaders()
    }

    var parametersEncoding: ParametersEncoding {
        return .json
    }
}

