//
//  MapPoints.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

struct MapPoints {
    let start: Airport
    let end: Airport

    init(start: Airport, end: Airport) {
        self.start = start
        self.end = end
    }
}

extension MapPoints {

    static func withDefaultStartPoint(endPoint: Airport) -> MapPoints {
        return MapPoints(start: .saintPetersburg, end: endPoint)
    }
}
