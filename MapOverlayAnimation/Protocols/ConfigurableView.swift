//
//  ConfigurableView.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

protocol ConfigurableView {

    associatedtype ViewModelT: ViewModel

    func configure(with viewModel: ViewModelT)
}

protocol ConfigurableCell: ConfigurableView {

    static var height: CGFloat? { get }
}

extension ConfigurableCell {

    static var height: CGFloat? {
        return nil
    }
}
