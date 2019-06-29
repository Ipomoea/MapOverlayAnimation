//
//  TableSection.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

open class TableSection {

    open var cells: [TableRowProtocol]

    public var numberOfItems: Int { cells.count }

    public init(_ cells: [TableRowProtocol]) {
        self.cells = cells
    }
}
