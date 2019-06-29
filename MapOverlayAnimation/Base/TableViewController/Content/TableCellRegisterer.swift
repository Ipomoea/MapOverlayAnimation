//
//  TableCellRegisterer.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 20.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

final class TableCellRegisterer {

    private var registeredIds = Set<String>()
    private weak var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func register(cellType: UITableViewCell.Type) {
        let reuseIdentifier = cellType.reuseIdentifier
        guard !registeredIds.contains(reuseIdentifier), let tableView = tableView else {
            return
        }

        if tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) != nil {
            registeredIds.insert(reuseIdentifier)
            return
        }

        let bundle = Bundle(for: cellType)

        if let _ = bundle.path(forResource: reuseIdentifier, ofType: "nib") {
            tableView.register(UINib(nibName: reuseIdentifier, bundle: bundle), forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }

        registeredIds.insert(reuseIdentifier)
    }
}
