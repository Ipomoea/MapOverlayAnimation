//
//  UITableViewExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

extension UITableView {

    func scrollToTop(animated: Bool = false) {
        guard numberOfSections > 0, numberOfRows(inSection: 0) > 0 else {
            return
        }
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
    }

    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func reloadVisibleRows(with animation: UITableView.RowAnimation = .none) {
        reloadRows(at: indexPathsForVisibleRows ?? [], with: animation)
    }
}
