//
//  UIViewExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    func roundView() {
        let size = bounds.size
        let dimension = min(size.width, size.height)
        let radius = dimension / 2
        layer.cornerRadius = radius
    }

    func renderImage() -> UIImage {
        return UIGraphicsImageRenderer(bounds: bounds).image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func pinCenterToSuperview() {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }

    func pinToSuperview() {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
