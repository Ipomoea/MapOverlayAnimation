//
//  CurveCalculator.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

struct CurveCalculator {

    let accuracy = 25

    func calculateSinusoidalWaveBetween(_ a: Coordinates, _ b: Coordinates) -> [Coordinates] {
        let x1 = a.latitude
        let y1 = a.longitude
        let x2 = b.latitude
        let y2 = b.longitude

        let slo = (y2 - y1) / (x2 - x1)
        let th = atan(slo)

        let c = cos(th)
        let s = sin(th)

        let A = -slo / (4 * .pi)
        let K = (x2 - x1) / c

        return (0...accuracy).map {
            let t = Double($0) / Double(accuracy)
            return Coordinates(
                latitude: K * (c * t - 0.3 * s * sin(2 * .pi * t)) + x1,
                longitude: K * (s * t + A * sin(2 * .pi * t)) + y1
            )
        }
    }
}
