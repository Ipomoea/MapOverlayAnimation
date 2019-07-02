//
//  StateManagerDelegate.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

public protocol StateManagerDelegate: class {

    var contentView: UIView { get }
    var rootView: UIView { get }

    func retry()
}

public extension StateManagerDelegate where Self: UIViewController {

    var rootView: UIView {
        return view
    }
}
