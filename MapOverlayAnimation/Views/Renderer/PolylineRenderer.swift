//
//  PolylineRenderer.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

final class PolylineRenderer: MKPolylineRenderer {

    override init(overlay: MKOverlay) {
        super.init(overlay: overlay)
        lineDashPattern = [1.0, 3.0]
        strokeColor = UIColor.moa.blueColor
    }
}
