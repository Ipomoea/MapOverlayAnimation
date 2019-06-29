//
//  PlaceholderView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 29.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(Constants.defaultPadding)
        }

        descriptionLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top).offset(Constants.defaultSpacing)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(Constants.defaultPadding)
        }

        button.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.defaultSpacing)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(Constants.defaultPadding)
        }

        super.updateConstraints()
    }

    private func setup() {
        addSubviews(titleLabel, descriptionLabel, button)

        [titleLabel, descriptionLabel].forEach {
            $0.numberOfLines = 0
        }
    }
}
