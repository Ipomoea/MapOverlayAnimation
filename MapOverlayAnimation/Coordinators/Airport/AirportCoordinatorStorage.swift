//
//  AirportCoordinatorStorage.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

final class AirportCoordinatorStorage {

    let networkService: NetworkService
    let countryService: CountryService

    init() {
        let networkService = NetworkService()
        self.networkService = networkService
        self.countryService = CountryService(networkService: networkService)
    }
}
