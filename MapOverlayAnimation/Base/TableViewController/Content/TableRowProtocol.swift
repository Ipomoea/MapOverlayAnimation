//
//  CellViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

public protocol TableRowProtocol {

    var reuseIdentifier: String { get }

    var cellClass: UITableViewCell.Type { get }

    var height: CGFloat { get }

    func configure(_ cell: UITableViewCell)
}

public extension TableRowProtocol {

    var reuseIdentifier: String { cellClass.reuseIdentifier }
}
