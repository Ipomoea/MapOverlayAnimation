//
//  FlightMapViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

final class FlightMapViewModel: ControllerViewModel {

    var title: String {
        return "flight_map_title".localized()
    }

    var pinViewModels: [AirportPinViewModel] {
        return [
            startPointViewModel,
            endPointViewModel
        ]
    }

    private let mapPoints: MapPoints
    private let curveCalculator = CurveCalculator()

    var startPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.start)
    }

    var endPointViewModel: AirportPinViewModel {
        return AirportPinViewModel(airport: mapPoints.end)
    }

    init(mapPoints: MapPoints) {
        self.mapPoints = mapPoints
    }

    func calculateCurve() -> Single<[CLLocationCoordinate2D]> {
        return .create { [curveCalculator, mapPoints] subscriber -> Disposable in
            DispatchQueue.global(qos: .default).async {
                let coordinates = curveCalculator.calculateSinusoidalWaveBetween(
                    mapPoints.start.location.clCoordinates,
                    mapPoints.end.location.clCoordinates
                )
                subscriber(.success(coordinates))
            }
            return Disposables.create()
        }
    }
}
