//
//  TableSection.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

class TableSection {

    var cells: [TableRowProtocol]

    var numberOfItems: Int {
        return cells.count
    }

    init(_ cells: [TableRowProtocol]) {
        self.cells = cells
    }
}
