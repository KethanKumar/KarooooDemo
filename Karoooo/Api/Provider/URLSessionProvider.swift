//
//  URLSessionProvider.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//

// MARK: - LoginCustomerLoginResponse
struct mettaGenericResponse<T: Codable>: Codable, Error {
    var mData: T?
    var mMsg: String
    var mResponseCode: Int
    var status: Bool
}

import Foundation

final class URLSessionProvider: ProviderProtocol {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func requestString(service: ServiceProtocol, completion: @escaping (NetworkResponseString) -> Void) {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponseString(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    // swiftlint:disable all
    private func handleDataResponseString(data: Data?, response: HTTPURLResponse?, error: Error?, completion: @escaping (NetworkResponseString) -> Void) {
        DispatchQueue.main.async {
            guard error == nil else { return completion(.failure(.unknown)) }
            guard let response = response else { return completion(.failure(.noData)) }

            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorTimedOut:
                    completion(.failure(.timeout))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.noInternetConnection))
                default:
                    completion(.failure(.unknown))
                }
            }
            switch response.statusCode {
            // Success cases
            case 200...299, 403, 500, 404:
                guard let data = data else { return completion(.failure(.unknown)) }
                let model = String(data: data, encoding: .ascii)
                completion(.success(model ?? ""))
            case 401:
                debugPrint("Invalid token error")
                completion(.failure(.invalidToken))
            case  422:
                //decoding error check
                debugPrint("422 error")
                completion(.failure(.unknown))
            default:
                debugPrint("Other error")
                completion(.failure(.unknown))
            }
        }
    }

    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable  {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }
    // swiftlint:disable all
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: @escaping (NetworkResponse<T>) -> Void) {
        DispatchQueue.main.async {
            guard error == nil else { return completion(.failure(.unknown)) }
            guard let response = response else { return completion(.failure(.noData)) }

            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorTimedOut:
                    completion(.failure(.timeout))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.noInternetConnection))
                default:
                    completion(.failure(.unknown))
                }
            }
            switch response.statusCode {
            // Success cases
            case 200...299, 403, 500, 404:
                guard let data = data else { return completion(.failure(.unknown)) }
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(T: model))
                } catch {
                    debugPrint("Decode error")
                    completion(.failure(.decodingError(error)))
                }
            case 401:
                debugPrint("Invalid token error")
                completion(.failure(.invalidToken))
            case  422:
                //decoding error check
                debugPrint("422 error")
                completion(.failure(.unknown))
            default:
                debugPrint("Other error")
                completion(.failure(.unknown))
            }
        }
    }

}
