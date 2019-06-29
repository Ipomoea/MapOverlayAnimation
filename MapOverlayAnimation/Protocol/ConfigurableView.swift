//
//  ConfigurableView.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

public protocol ConfigurableView {

    associatedtype ViewModelT: Hashable, ViewModel

    func configure(with viewModel: ViewModelT)
}

public protocol ConfigurableCell: ConfigurableView {

    static var height: CGFloat? { get }
}

public extension ConfigurableCell {

    static var height: CGFloat? { nil }
}
