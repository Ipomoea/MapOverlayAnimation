//
//  TableViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

class TableViewController<TableViewModelT: TableViewModel>: StateViewController<TableViewModelT>, UITableViewDataSource, UITableViewDelegate {

    /// Main table view
    let tableView: UITableView

    /// Main table view data source
    /// Set this property to see data on the table
    var sections: [TableSection] = [] {
        didSet { registerCells() }
    }

    /// Shows if table is not empty
    var hasContent: Bool {
        return !allCells.isEmpty
    }

    private var allCells: [TableRowProtocol] {
        return sections.flatMap { $0.cells }
    }

    private var cellTypes: [UITableViewCell.Type] {
        return allCells.map { $0.cellClass }
    }

    private let registerer: TableCellRegisterer

    private var isInitialLoad = true

    required init(viewModel: TableViewModelT) {
        let tableView = UITableView()
        self.tableView = tableView
        self.registerer = TableCellRegisterer(tableView: tableView)
        super.init(viewModel: viewModel)
    }

    override func viewDidLoad() {
        configureTableViewController()
        super.viewDidLoad()
        setupTableConstraints()
        viewModel.reload()
    }

    /// Setup constraints here
    /// Don't call super if you don't want to pin `tableView` to superview
    func setupTableConstraints() {
        tableView.pinToSuperview()
    }

    /// Override point
    /// Calls when view model initiates reload.
    /// - Parameter initialLoad: Flag that shows if load was exected first time
    func reloadTableView(initialLoad: Bool) { }

    /// Make `tableView` configuration here
    /// Super is requred
    func configureTableView(tableView: UITableView) {
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        contentView.addSubview(tableView)
        tableView.frame = view.bounds
    }

    /// Method that returns cell view model at index path
    /// Warning! Method is not safe. Make sure you provide existing index path and proper cell type
    /// - Parameter indexPath: Index path of desire cell
    /// - Parameter cellType: Cell type
    func cellViewModel<Cell: UITableViewCell & ConfigurableCell, Row: TableRow<Cell>>(
        at indexPath: IndexPath,
        cellType: Cell.Type
    ) -> Row.CellViewModel {
        return (row(at: indexPath) as! Row).cellViewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableRow = row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: tableRow.reuseIdentifier, for: indexPath)
        tableRow.configure(cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return row(at: indexPath).height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func configureTableViewController() {
        configureTableView(tableView: tableView)
        viewModel.reloadAction = { [weak self] in
            guard let self = self else {
                return
            }

            self.reloadTableView(initialLoad: self.isInitialLoad)
            if self.isInitialLoad {
                self.isInitialLoad = false
            }
        }
    }

    private func registerCells() {
        cellTypes.forEach { registerer.register(cellType: $0) }
    }
}

private extension TableViewController {

    func row(at indexPath: IndexPath) -> TableRowProtocol {
        return sections[indexPath.section].cells[indexPath.row]
    }
}
