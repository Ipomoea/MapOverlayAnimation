//
//  DoubleExtensions.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 01.07.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

extension Double {

    func degreesToRadians() -> Double {
        return self * .pi / 180.0
    }

    func radiansToDegrees() -> Double {
        return self * 180.0 / .pi
    }
}
