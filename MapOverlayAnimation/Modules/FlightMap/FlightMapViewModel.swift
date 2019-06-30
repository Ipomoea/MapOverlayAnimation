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
        return "Карта"
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

    func calculateCurve() -> Observable<[CLLocationCoordinate2D]> {
        return .create { [curveCalculator, mapPoints] subscriber -> Disposable in
            DispatchQueue.global(qos: .default).async {
                let coordinates = curveCalculator.calculateSinusoidalWaveBetween(
                    mapPoints.start.location,
                    mapPoints.end.location
                )
                subscriber.onNext(coordinates.map { $0.clCoordinates })
            }
            return Disposables.create()
        }
    }
}
