//
//  PlaceholderImageView.swift
//  Currencies
//
//  Created by Pavel Lukandiy on 08/12/2018.
//  Copyright © 2018 Pavel Lukandiy. All rights reserved.
//

import UIKit
import SnapKit

final class PlaceholderImageView: UIImageView {

    var title = Character(" ") {
        didSet { setNeedsLayout() }
    }

    var textColor: UIColor = .white {
        didSet { setNeedsLayout() }
    }

    var font: UIFont = .systemFont(ofSize: 20.0) {
        didSet { setNeedsLayout() }
    }

    override var image: UIImage? {
        didSet { setNeedsLayout() }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()

    private func configure() {
        let titleString = String(title)
        let isHidden = titleString.isEmpty || image != nil
        label.isHidden = isHidden

        if !isHidden {
            label.text = titleString
            label.textColor = textColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }

    override func updateConstraints() {
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }

        super.updateConstraints()
    }
}
