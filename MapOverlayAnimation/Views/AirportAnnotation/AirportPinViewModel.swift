//
//  AirportPinViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

final class AirportPinViewModel: NSObject, MKAnnotation, ViewModel {

    let airport: Airport

    var coordinate: CLLocationCoordinate2D {
        return airport.location.clCoordinates
    }

    var iata: String {
        return airport.iata
    }

    init(airport: Airport) {
        self.airport = airport
    }
}
