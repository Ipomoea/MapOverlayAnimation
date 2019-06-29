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
        case indexStrings = "index_strings"
        case iata
        case name
        case location
        case countryIata = "country_iata"
        case searchesCount = "searches_count"
    }

    let airportName: String?
    let indexStrings: [String]
    let iata: String
    let name: String
    let location: Coordinates

    let countryIata: String
    let searchesCount: Int
}
