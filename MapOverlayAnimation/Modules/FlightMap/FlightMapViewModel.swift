//
//  FlightMapViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import CoreLocation

final class FlightMapViewModel: ControllerViewModel {

    var title: String {
        return "Карта"
    }

    var startPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.start)
    }

    var endPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.end)
    }

    private let mapPoints: MapPoints

    init(mapPoints: MapPoints) {
        self.mapPoints = mapPoints
    }
}
