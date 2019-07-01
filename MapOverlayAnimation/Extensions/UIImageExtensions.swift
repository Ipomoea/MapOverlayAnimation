//
//  UIImageExtensions.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 01.07.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import CoreLocation

extension UIImage {

    func rotated(by rotationAngle: CLLocationDirection) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

        let rotationInRadians = CGFloat(rotationAngle)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: size).applying(transform)
        rect.origin = .zero

        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)

            let drawRect = CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}

