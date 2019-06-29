//
//  TableRow.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import DeepDiff

final class TableRow<CellType: ConfigurableCell>: TableRowProtocol where CellType: UITableViewCell, CellType.ViewModelT: Hashable {

    typealias CellViewModel = CellType.ViewModelT

    let cellViewModel: CellViewModel

    var cellClass: UITableViewCell.Type {
        return CellType.self
    }

    init(cellViewModel: CellViewModel) {
        self.cellViewModel = cellViewModel
    }

    func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(with: cellViewModel)
    }

    var height: CGFloat {
        return (cellClass as? CellType.Type)?.height ?? UITableView.automaticDimension
    }
}

extension TableRow: Hashable {

    static func == (lhs: TableRow, rhs: TableRow) -> Bool {
        return lhs.cellViewModel == rhs.cellViewModel
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(cellViewModel)
    }
}

extension TableRow: DiffAware {

    var diffId: Int {
        return hashValue
    }

    static func compareContent(_ a: TableRow<CellType>, _ b: TableRow<CellType>) -> Bool {
        return a == b
    }
}
