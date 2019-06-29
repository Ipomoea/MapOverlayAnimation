//
//  FlightMapViewController.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import MapKit

final class FlightMapViewController: ViewController<FlightMapViewModel> {

    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.pinToSuperview()
    }
}
