//
//  PlaceholderView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 29.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

final class PlaceholderView: UIView, ConfigurableView {

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    var onRetry: VoidClosure?

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

        titleLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top).inset(-Constants.defaultSpacing)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(Constants.defaultPadding)
        }

        button.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.defaultSpacing)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(Constants.defaultPadding)
        }

        super.updateConstraints()
    }

    func configure(with viewModel: PlaceholderViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        button.setTitle(viewModel.buttonTitle, for: .normal)
        setNeedsUpdateConstraints()
    }

    private func setup() {
        addSubviews(titleLabel, descriptionLabel, button)

        [titleLabel, descriptionLabel].forEach {
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }

        titleLabel.font = UIFont.moa.titleFont()
        descriptionLabel.font = UIFont.moa.descriptionFont()

        titleLabel.textColor = UIColor.moa.titleColor
        descriptionLabel.textColor = UIColor.moa.descriptionColor

        button.titleLabel?.font = UIFont.moa.descriptionFont()
        button.setTitleColor(UIColor.moa.actionColor, for: .normal)
        button.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }

    @objc
    private func retry() {
        onRetry?()
    }
}
