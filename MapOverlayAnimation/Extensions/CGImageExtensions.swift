//
//  UIImageExtensions.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 01.07.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import CoreLocation

extension CGImage {

    func rotated(by rotationAngle: CLLocationDirection) -> CGImage? {
        guard let colorSpace = colorSpace else {
            return nil
        }

        let newContext = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )

        guard let context = newContext else {
            return nil
        }

        context.translateBy(x: CGFloat(width) / 2.0, y: CGFloat(height) / 2.0)

        context.scaleBy(x: 1.0, y: -1.0)

        context.rotate(by: CGFloat(rotationAngle))
        context.translateBy(x: -CGFloat(width) / 2.0, y: -CGFloat(height) / 2.0)
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))

        return context.makeImage()
    }
}

