//
//  FlightOverlayView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

final class FlightOverlayView: MKOverlayRenderer {

    private let imageResource = UIImage(named: "plane")?.cgImage
    private let viewModel: FlightOverlayViewModel

    init(overlay: FlightOverlayViewModel) {
        viewModel = overlay
        super.init(overlay: overlay)

        viewModel.onRedraw = { [weak self] in
            self?.setNeedsDisplay()
        }
    }

    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        super.draw(mapRect, zoomScale: zoomScale, in: context)

        guard let imageReference = imageResource?.rotated(by: viewModel.course) else {
            return
        }

        let convertedRect = rect(for: viewModel.imageRectForCurrentStep(scale: zoomScale))
        context.translateBy(x: 0.0, y: -convertedRect.size.height)
        context.draw(imageReference, in: convertedRect)
    }
}
