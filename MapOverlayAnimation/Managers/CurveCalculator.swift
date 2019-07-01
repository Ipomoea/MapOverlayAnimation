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
        let accuracy = 1000

        let x1 = a.latitude
        let y1 = a.longitude
        let x2 = b.latitude
        let y2 = b.longitude

        let dx = x2 - x1
        let dy = y2 - y1
        let d = sqrt(dx * dx + dy * dy)
        let a = atan2(dy, dx)
        let cosa = cos(a)
        let sina = sin(a)

        return (0..<accuracy).map {
            let tx = Double($0) / Double(accuracy)
            let ty = 0.1 * sin(tx * 2 * .pi)

            return CLLocationCoordinate2D(
                latitude: x1 + d * (tx * cosa - ty * sina),
                longitude: y1 + d * (tx * sina + ty * cosa)
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
