//
//  ReloadableTableViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 19.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import DeepDiff

/// Helper class with implemented `reloadTableView(initialLoad: Bool)` function
/// Just set view models to `cellViewModels` in `ReloadableTableViewModel` and they wil be shown autpmatically
/// Works with only one type of cell
open class ReloadableTableViewController<Cell: UITableViewCell & ConfigurableCell, ViewModel: ReloadableTableViewModel<Cell.ViewModelT>>: TableViewController<ViewModel> {

    open var reloadAnimation: UITableView.RowAnimation { .none }

    private var rows: [TableRow<Cell>] = [] {
        didSet { sections = [TableSection(rows)] }
    }

    override open func reloadTableView(initialLoad: Bool) {
        super.reloadTableView(initialLoad: initialLoad)

        let updatedRows = viewModel.cellViewModels.map { TableRow<Cell>(cellViewModel: $0) }
        let changes = diff(old: rows, new: updatedRows)
        rows = updatedRows

        if initialLoad {
            tableView.reloadData()
        } else if !changes.isEmpty {
            tableView.reload(
                changes: changes,
                insertionAnimation: reloadAnimation,
                deletionAnimation: reloadAnimation,
                replacementAnimation: reloadAnimation,
                updateData: { }
            )
        }
    }
}
