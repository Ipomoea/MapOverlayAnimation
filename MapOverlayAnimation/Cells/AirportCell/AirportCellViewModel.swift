//
//  CityCellViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AirportCellViewModel: ViewModel, Hashable {

    let airport: Airport

    var airportName: String {
        return (airport.airportName ?? cityTitle) + " (\(airport.iata))"
    }

    var cityTitle: String {
        return airport.name
    }

    var flagDriver: Driver<URL?> {
        return countryService
            .coutryObservable(from: airport.countryIata)
            .map { $0?.flag }
            .asDriver(onErrorJustReturn: nil)
    }

    private let countryService: CountryService

    init(airport: Airport, countryService: CountryService) {
        self.airport = airport
        self.countryService = countryService
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(airport)
    }

    static func == (lhs: AirportCellViewModel, rhs: AirportCellViewModel) -> Bool {
        return lhs.airport == rhs.airport
    }
}
