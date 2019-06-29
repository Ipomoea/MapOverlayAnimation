//
//  UIViewControllerExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

public extension UIViewController {

    func embedInNavigationController<T: UINavigationController>() -> T {
        T(rootViewController: self)
    }
}
