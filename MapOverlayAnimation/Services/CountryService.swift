//
//  CountryService.swift
//  Currencies
//
//  Created by Pavel Lukandiy on 07/01/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let CountryServiceDidLoadCountries = Notification.Name(rawValue: "CountryServiceDidLoadCountries")
}

final class CountryService {

    enum State {
        case initial
        case data
        case loading
        case error(Swift.Error)
    }

    private(set) var state: State = .initial

    private let networkService: NetworkService
    private var countries: [Country] = []

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func requestCountries() {
        if case .loading = state {
            return
        }

        state = .loading
        networkService.getCountries { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let value):
                self.countries = value
                self.state = .data
                NotificationCenter.default.post(
                    name: .CountryServiceDidLoadCountries,
                    object: nil
                )
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    func country(from currency: Currency) -> Country? {
        countries.first { $0.currencies
            .compactMap { $0.code }
            .contains(currency.rawValue) }
    }

    func countryCurrency(from currency: Currency) -> CountryCurrency? {
        countries
            .flatMap { $0.currencies }
            .first { $0.code == currency.rawValue }
    }
}
