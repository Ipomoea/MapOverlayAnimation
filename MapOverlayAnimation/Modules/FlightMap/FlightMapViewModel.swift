//
//  FlightMapViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

final class FlightMapViewModel: ControllerViewModel {

    var title: String {
        return "Карта"
    }

    private let airport: Airport

    init(airport: Airport) {
        self.airport = airport
    }
}
