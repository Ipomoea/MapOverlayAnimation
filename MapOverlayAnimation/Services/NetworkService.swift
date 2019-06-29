//
//  NetworkService.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Alamofire

final class NetworkService {

    typealias Result<T> = JSONDecoder.Result<T>

    private let sessionManager = SessionManager.default
    private let decoder = JSONDecoder()

    private enum PlacesRouter: Alamofire.URLRequestConvertible {

        private static let baseURLString = "http://places.aviasales.ru"

        case places(term: String, locale: String)

        private var method: HTTPMethod {
            switch self {
            case .places:
                return .get
            }
        }

        private var path: String {
            switch self {
            case .places:
                return "/places"
            }
        }

        func asURLRequest() throws -> URLRequest {
            let url = try PlacesRouter.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .places(let term, let locale):
                let parameters: [String: String] = [
                    "term": term,
                    "locale": locale
                ]
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
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

    private func request<T: Decodable>(router: URLRequestConvertible, resultClosure: @escaping ParameterClosure<Result<T>>) -> Cancelable {
        let request = sessionManager.request(router)
        request.responseData(queue: .global(qos: .default)) { [unowned decoder] in
            resultClosure(decoder.decodeResponse(from: $0))
        }
        return request
    }
}

extension NetworkService {

    func getPlaces(from term: String, locale: String, resultClosure: @escaping ParameterClosure<Result<AirportList>>) -> Cancelable {
        return request(router: PlacesRouter.places(term: term, locale: locale), resultClosure: resultClosure)
    }

    func getCountries(resultClosure: @escaping ParameterClosure<Result<[Country]>>) -> Cancelable {
        return request(router: CountryRouter.allCountries, resultClosure: resultClosure)
    }
}
