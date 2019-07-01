//
//  FlightOverlayViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

final class FlightOverlayViewModel: NSObject, MKOverlay, ViewModel {

    var onRedraw: VoidClosure?

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }

    var boundingMapRect: MKMapRect {
        return .world
    }

    var rotatedImage: UIImage? {
        return imageResource.rotated(by: course)
    }

    private let imageResource = #imageLiteral(resourceName: "plane")

    private let calculator = CurveCalculator()
    private let repeatingTimer = DispatchSource.makeTimerSource()

    private let locations: [CLLocationCoordinate2D]

    private var step = 0
    private var reversed = false

    private var course: CLLocationDirection {
        return -calculateCourse() + (.pi / 2)
    }

    private var timerInterval: TimeInterval {
        return Constants.animationDuration / TimeInterval(locationsCount)
    }

    private var locationsCount: Int {
        return locations.count
    }

    init(locations: [CLLocationCoordinate2D]) {
        self.locations = locations
        super.init()

        repeatingTimer.setEventHandler { [weak self] in
            self?.timerFired()
        }
        startTimer()
    }

    deinit {
        stopTimer()
    }

    func imageRectForCurrentStep(scale: MKZoomScale) -> MKMapRect {
        let mapPointOrigin = MKMapPoint(locations[step])
        let size = MKMapSize(
            width: Constants.imageDimension / Double(scale),
            height: Constants.imageDimension / Double(scale)
        )
        return MKMapRect(
            x: mapPointOrigin.x - size.width / 2,
            y: mapPointOrigin.y + size.height / 2,
            width: size.width,
            height: size.height
        )
    }

    private func incrementStep() {
        reversed ? (step -= 1) : (step += 1)

        if step >= locationsCount - 2 || (step <= 1 && reversed) {
            reversed.toggle()
        }
    }

    private func calculateCourse() -> CLLocationDirection {
        let seconeLocation = reversed ? locations[step - 1] : locations[step + 1]
        return calculator.calculateCourseBetween(locations[step], seconeLocation)
    }

    private func startTimer() {
        scheduleTimer()
        repeatingTimer.resume()
    }

    private func stopTimer() {
        repeatingTimer.setEventHandler(handler: nil)
        repeatingTimer.cancel()
    }

    private func scheduleTimer() {
        repeatingTimer.schedule(deadline: .now() + timerInterval)
    }

    private func timerFired() {
        incrementStep()
        onRedraw?()
        scheduleTimer()
    }
}

private extension Constants {
    static let imageDimension: Double = 48.0
    static let animationDuration: TimeInterval = 10.0
}
