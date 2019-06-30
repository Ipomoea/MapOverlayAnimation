//
//  Coordinate.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = Double

struct Coordinates: Codable, Hashable {

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }

    let latitude: Coordinate
    let longitude: Coordinate
}

extension Coordinates {

    var clCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
