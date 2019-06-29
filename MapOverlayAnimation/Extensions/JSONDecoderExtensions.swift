//
//  Airport.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Alamofire

extension JSONDecoder {

    typealias Result<T> = Swift.Result<T, Error>

    enum Error: Swift.Error {
        case parsing
        case response(Swift.Error)
    }

    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        if let responseError = response.error {
            return .failure(.response(responseError))
        }

        guard let responseData = response.data else {
            return .failure(.parsing)
        }

        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            return .failure(.parsing)
        }
    }
}
