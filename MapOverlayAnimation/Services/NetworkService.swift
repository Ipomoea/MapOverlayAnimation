//
//  NetworkService.swift
//  Currencies
//
//  Created by Pavel Lukandiy on 02/12/2018.
//  Copyright © 2018 Pavel Lukandiy. All rights reserved.
//

import Alamofire
import Tangerine

final class NetworkService {

    typealias Result<T> = JSONDecoder.Result<T>

    private let sessionManager = SessionManager.default
    private let decoder = JSONDecoder()

    private enum CurrencyRouter: Alamofire.URLRequestConvertible {

        private static let baseURLString = "https://revolut.duckdns.org/"

        case currencies(currency: Currency)

        private var method: HTTPMethod {
            switch self {
            case .currencies:
                return .get
            }
        }

        private var path: String {
            switch self {
            case .currencies:
                return "/latest"
            }
        }

        func asURLRequest() throws -> URLRequest {
            let url = try CurrencyRouter.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .currencies(let currency):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: ["base": currency])
            }

            return urlRequest
        }
    }

    private enum CountryRouter: Alamofire.URLRequestConvertible {

        private static let baseURLString = "https://restcountries.eu/rest/v2"

        case allCountries

        private var method: HTTPMethod {
            switch self {
            case .allCountries:
                return .get
            }
        }

        private var path: String {
            switch self {
            case .allCountries:
                return "/all"
            }
        }

        func asURLRequest() throws -> URLRequest {
            let url = try CountryRouter.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .allCountries:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            }

            return urlRequest
        }
    }

    private func request<T: Decodable>(router: URLRequestConvertible, resultClosure: @escaping ParameterClosure<Result<T>>) {
        sessionManager
            .request(router)
            .responseData(queue: .global(qos: .default)) { [unowned decoder] in
                resultClosure(decoder.decodeResponse(from: $0))
            }
    }
}

extension NetworkService {

    func getCurrencies(from currency: Currency, resultClosure: @escaping ParameterClosure<Result<CurrencyResponse>>) {
        request(router: CurrencyRouter.currencies(currency: currency), resultClosure: resultClosure)
    }

    func getCountries(resultClosure: @escaping ParameterClosure<Result<[Country]>>) {
        request(router: CountryRouter.allCountries, resultClosure: resultClosure)
    }
}
