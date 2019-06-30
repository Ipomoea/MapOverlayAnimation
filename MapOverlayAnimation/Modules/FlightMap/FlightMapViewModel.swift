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

    var pinViewModels: [AirportPinViewModel] {
        return [
            startPointViewModel,
            endPointViewModel
        ]
    }

    var pinCoordinates: [CLLocationCoordinate2D] {
        return pinViewModels.map { $0.coordinate }
    }

    private let mapPoints: MapPoints

    var startPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.start)
    }

    var endPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.end)
    }

    init(mapPoints: MapPoints) {
        self.mapPoints = mapPoints
    }
}
