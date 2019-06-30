//
//  MKMapViewExtensions.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import MapKit

extension MKMapView {

    func fitAllAnnotations(padding: CGFloat, animated: Bool = false) {
        var zoomRect: MKMapRect = .null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect = zoomRect.union(pointRect);
        }

        setVisibleMapRect(
            zoomRect,
            edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding),
            animated: animated
        )
    }
}
