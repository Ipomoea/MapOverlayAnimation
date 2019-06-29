//
//  UITableViewCellExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

public extension UITableViewCell {

    static var reuseIdentifier: String { String(describing: self) }
}
