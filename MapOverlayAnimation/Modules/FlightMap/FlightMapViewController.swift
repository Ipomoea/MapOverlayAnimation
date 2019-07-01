//
//  FlightMapViewController.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

final class FlightMapViewController: ViewController<FlightMapViewModel> {

    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        addAttractions()
        mapView.fitAllAnnotations(padding: Constants.annotationPadding)

        viewModel.calculateCurve()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] coordinates in
                self?.addRoute(curve: coordinates)
                self?.addAnimation(curve: coordinates)
            })
            .disposed(by: disposeBag)
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.pinToSuperview()
    }

    private func addAttractions() {
        mapView.addAnnotations(viewModel.pinViewModels)
    }

    private func addRoute(curve: [CLLocationCoordinate2D]) {
        let polyline = MKPolyline(coordinates: curve, count: curve.count)
        mapView.addOverlay(polyline)
    }

    private func addAnimation(curve: [CLLocationCoordinate2D]) {
        let overlay = FlightOverlayViewModel(locations: curve)
        mapView.addOverlay(overlay)
    }
}

extension FlightMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = AirportAnnotationView(reuseIdentifier: "airport_annotation")
        if let pinViewModel = annotation as? AirportPinViewModel {
            annotationView.configure(with: pinViewModel)
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let flightOverlay = overlay as? FlightOverlayViewModel {
            return FlightOverlayView(overlay: flightOverlay)
        } else if overlay is MKPolyline {
            return PolylineRenderer(overlay: overlay)
        }

        return MKOverlayRenderer()
    }
}

private extension Constants {
    static let annotationPadding: CGFloat = 90.0
}
