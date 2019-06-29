//
//  ArrayExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

public extension Array {

    mutating func replace(from fromIndex: Int, to toIndex: Int) {
        let element = self[fromIndex]
        remove(at: fromIndex)
        insert(element, at: toIndex)
    }
}
