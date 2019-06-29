//
//  CellViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

protocol TableRowProtocol {

    var reuseIdentifier: String { get }

    var cellClass: UITableViewCell.Type { get }

    var height: CGFloat { get }

    func configure(_ cell: UITableViewCell)
}

extension TableRowProtocol {

    var reuseIdentifier: String {
        return cellClass.reuseIdentifier
    }
}
