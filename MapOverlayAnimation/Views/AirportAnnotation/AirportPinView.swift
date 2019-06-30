//
//  AirportAnnotationView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

final class AirportPinView: UIView, ConfigurableView {

    private let iataLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: Constants.width, height: Constants.height)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let linePath = UIBezierPath(
            roundedRect: rect.insetBy(dx: Constants.lineWidth, dy: Constants.lineWidth),
            cornerRadius: Constants.height / 2
        )
        linePath.lineWidth = Constants.lineWidth

        UIColor.moa.whiteOverlayColor.set()
        linePath.fill()

        UIColor.moa.blueColor.set()
        linePath.stroke()

        iataLabel.frame = rect

        if iataLabel.superview == nil {
            addSubview(iataLabel)
            iataLabel.textAlignment = .center
            iataLabel.textColor = UIColor.moa.blueColor
            iataLabel.font = UIFont.moa.boldFont(of: 14)
        }
    }

    func configure(with viewModel: AirportPinViewModel) {
        iataLabel.text = viewModel.iata
    }
}

private extension Constants {
    static let width: CGFloat = 54.0
    static let height: CGFloat = 26.0
    static let lineWidth: CGFloat = 2.0
}
