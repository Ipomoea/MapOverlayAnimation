//
//  SVGProcessor.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Kingfisher
import SVGgh

struct SVGProcessor: ImageProcessor {

    let imageSize: CGSize

    var identifier: String {
        return Constants.processorIdentifier
    }

    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            if let svgString = String(data: data, encoding: .utf8) {
                let renderer = SVGRenderer(string: svgString)
                return renderer.asImage(with: imageSize, andScale: UIScreen.main.scale)
            }
            return nil
        }
    }
}

private extension Constants {
    static let processorIdentifier = "com.pl.avia.svg"
}
