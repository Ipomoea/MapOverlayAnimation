//
//  TableRow.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import DeepDiff

final public class TableRow<CellType: ConfigurableCell>: TableRowProtocol where CellType: UITableViewCell {

    public typealias CellViewModel = CellType.ViewModelT

    public let cellViewModel: CellViewModel

    public var cellClass: UITableViewCell.Type { CellType.self }

    public init(cellViewModel: CellViewModel) {
        self.cellViewModel = cellViewModel
    }

    public func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(with: cellViewModel)
    }

    public var height: CGFloat {
        (cellClass as? CellType.Type)?.height ?? UITableView.automaticDimension
    }
}

extension TableRow: Hashable {

    public static func == (lhs: TableRow, rhs: TableRow) -> Bool {
        lhs.cellViewModel == rhs.cellViewModel
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellViewModel)
    }
}

extension TableRow: DiffAware {

    public var diffId: Int { hashValue }

    public static func compareContent(_ a: TableRow<CellType>, _ b: TableRow<CellType>) -> Bool {
        a == b
    }
}
