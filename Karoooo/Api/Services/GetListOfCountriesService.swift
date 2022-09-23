//
//  GetListOfCountriesService.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import Foundation

struct GetListOfCountriesDataModel: Codable {
    let name: Name?
    let postalCode: PostalCode?
}


// MARK: - Name
struct Name: Codable {
    let common, official: String?
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format, regex: String?
}


typealias GetListOfCountriesModel = [GetListOfCountriesDataModel]

enum GetListOfCountriesService: ServiceProtocol {

    case get

    var baseURL: URL {
        guard let url = URL(string: "https://restcountries.com") else { fatalError("BaseURL is nil") }
        return url
    }

    var path: String {
        return "/v3.1/all"
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

