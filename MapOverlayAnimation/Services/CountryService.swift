//
//  CountryService.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import RxSwift

final class CountryService {

    enum State {
        case initial
        case data
        case loading
        case error(Swift.Error)
    }

    var countriesObservable: Observable<[Country]> {
        return countriesSubject
            .asObservable()
            .catchErrorJustReturn([])
    }

    private(set) var state: State = .initial

    private let networkService: NetworkService
    private let countriesSubject = BehaviorSubject<[Country]>(value: [])

    init(networkService: NetworkService) {
        self.networkService = networkService
        requestCountries()
    }

    func requestCountries() {
        if case .loading = state {
            return
        }

        state = .loading
        _ = networkService.getCountries { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let value):
                self.countriesSubject.onNext(value)
                self.state = .data
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    func coutryObservable(from code: String) -> Observable<Country?> {
        return countriesObservable
            .map { $0.first { $0.alpha2Code == code || $0.alpha3Code == code } }
    }
}
