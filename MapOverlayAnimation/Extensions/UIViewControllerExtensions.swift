//
//  UIViewControllerExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

extension UIViewController {

    func embedInNavigationController<T: UINavigationController>() -> T {
        return T(rootViewController: self)
    }
}
