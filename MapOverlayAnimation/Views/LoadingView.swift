//
//  LoadingView.swift
//  Currencies
//
//  Created by Pavel Lukandiy on 19.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Tangerine

final class LoadingView: UIView {

    private let activityIndicator: UIActivityIndicatorView

    override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        super.init(frame: frame)
        addSubview(activityIndicator)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        activityIndicator.pinCenterToSuperview()
        super.updateConstraints()
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
