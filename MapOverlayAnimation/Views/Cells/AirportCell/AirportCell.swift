//
//  AirportCell.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class AirportCell: TableViewCell, ConfigurableCell {

    static var height: CGFloat? {
        return Constants.cellHeight
    }

    private let countryImageView = PlaceholderImageView()
    private let cityTitleLabel = UILabel()
    private let airportNameLabel = UILabel()

    private var disposable: Disposable?

    private let imageProcessor = SVGProcessor(
        imageSize: .init(
            width: Constants.imageViewDimension,
            height: Constants.imageViewDimension
        )
    )

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubviews(countryImageView, cityTitleLabel, airportNameLabel)
    }

    override func configureSubviews() {
        super.configureSubviews()

        airportNameLabel.textColor = UIColor.moa.titleColor
        airportNameLabel.font = UIFont.moa.titleFont()

        cityTitleLabel.textColor = UIColor.moa.descriptionColor
        cityTitleLabel.font = UIFont.moa.descriptionFont()

        countryImageView.textColor = UIColor.moa.titleColor
        countryImageView.font = UIFont.moa.boldFont(of: Constants.placeholderFontSize)
        countryImageView.backgroundColor = UIColor.moa.grayColor
        countryImageView.contentMode = .scaleAspectFill

        countryImageView.layer.cornerRadius = Constants.imageViewDimension / 2
        countryImageView.layer.masksToBounds = true
    }

    override func updateConstraints() {
        countryImageView.snp.remakeConstraints { make in
            make.leading.top.equalToSuperview().inset(Constants.defaultPadding)
            make.width.height.equalTo(Constants.imageViewDimension)
        }

        airportNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(countryImageView.snp.top)
            make.trailing.lessThanOrEqualToSuperview().inset(Constants.defaultSpacing)
            make.leading.equalTo(countryImageView.snp.trailing).offset(Constants.defaultPadding)
        }

        cityTitleLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(countryImageView.snp.bottom)
            make.trailing.lessThanOrEqualToSuperview().inset(Constants.defaultSpacing)
            make.leading.equalTo(countryImageView.snp.trailing).offset(Constants.defaultPadding)
        }

        super.updateConstraints()
    }

    func configure(with viewModel: AirportCellViewModel) {
        disposable?.dispose()

        airportNameLabel.text = viewModel.airportName
        cityTitleLabel.text = viewModel.cityTitle
        countryImageView.title = viewModel.airportName.first ?? Character(" ")

        disposable = viewModel.flagDriver
            .drive(onNext: { [imageProcessor, weak countryImageView] url in
                countryImageView?.kf.setImage(with: url, options: [.processor(imageProcessor)])
            })
    }
}

private extension Constants {
    static let placeholderFontSize: CGFloat = 36.0
    static let lineHeight: CGFloat = 2.0
    static let cellHeight: CGFloat = 84.0
    static let imageViewDimension: CGFloat = 52.0
}
