//
//  Airport.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

typealias AirportList = [Airport]

struct Airport: Codable, Hashable {

    enum CodingKeys: String, CodingKey {
        case airportName = "airport_name"
        case iata
        case name
        case location
        case countryIata = "country_iata"
    }

    let airportName: String?
    let iata: String
    let name: String
    let location: Coordinates
    let countryIata: String
}

extension Airport {

    static var saintPetersburg: Airport {
        return Airport(
            airportName: "Пулково",
            iata: "LED",
            name: "Санкт-Петербург, Россия",
            location: Coordinates(latitude: 59.806084, longitude: 30.3083),
            countryIata: "RU"
        )
    }
}
