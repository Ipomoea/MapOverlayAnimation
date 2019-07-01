//
//  CurveCalculator.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import CoreLocation

struct CurveCalculator {

    func calculateSinusoidalWaveBetween(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        let accuracy = 1500

        let x1 = a.latitude
        let y1 = a.longitude
        let x2 = b.latitude
        let y2 = b.longitude

        let slo = (y2 - y1) / (x2 - x1)
        let th = atan(slo)

        let c = cos(th)
        let s = sin(th)

        let A = slo / (8 * .pi)
        let K = (x2 - x1) / c

        return (0...accuracy).map {
            let t = Double($0) / Double(accuracy)
            return CLLocationCoordinate2D(
                latitude: K * (c * t - 0.3 * s * sin(2 * .pi * t)) + x1,
                longitude: K * (s * t + A * sin(2 * .pi * t)) + y1
            )
        }
    }

    func calculateCourseBetween(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDirection {

        let lat1 = a.latitude.degreesToRadians()
        let lon1 = a.longitude.degreesToRadians()

        let lat2 = b.latitude.degreesToRadians()
        let lon2 = b.longitude.degreesToRadians()

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)

        return radiansBearing
    }
}
