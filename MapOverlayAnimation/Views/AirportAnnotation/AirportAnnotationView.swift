//
//  AirportAnnotation.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

final class AirportAnnotationView: MKAnnotationView, ConfigurableView {

    private var pinView: AirportPinView?
    private var viewModel: AirportPinViewModel?

    init(reuseIdentifier: String) {
        super.init(annotation: nil, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        updateImage()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        updateImage()
    }

    private func updateImage() {
        let view = AirportPinView()
        pinView = view

        if let viewModel = viewModel {
            view.configure(with: viewModel)
        }

        image = view.renderImage()
    }

    func configure(with viewModel: AirportPinViewModel) {
        self.viewModel = viewModel
        pinView?.configure(with: viewModel)
    }
}
