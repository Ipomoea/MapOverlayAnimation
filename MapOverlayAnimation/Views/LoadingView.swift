//
//  LoadingView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

final class LoadingView: UIView {

    private let activityIndicator: UIActivityIndicatorView

    override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        super.init(frame: frame)
        addSubview(activityIndicator)
        activityIndicator.pinCenterToSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
