//
//  FlightMapViewController.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import MapKit

final class FlightMapViewController: ViewController<FlightMapViewModel>, MKMapViewDelegate {

    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        addAttractions()
        mapView.fitAllAnnotations(padding: Constants.annotationPadding)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = AirportAnnotationView(reuseIdentifier: "airport_annotation")
        if let pinViewModel = annotation as? AirportPinViewModel {
            annotationView.configure(with: pinViewModel)
        }
        return annotationView
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.pinToSuperview()
    }

    private func addAttractions() {
        mapView.addAnnotations([
            viewModel.startPointViewModel,
            viewModel.endPointViewModel
        ])
    }
}

private extension Constants {
    static let annotationPadding: CGFloat = 90.0
}
