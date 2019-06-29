//
//  ReloadableTableViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 20.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

open class ReloadableTableViewModel<CellViewModel: Hashable & ViewModel>: TableViewModel {

    public var reloadAction: VoidClosure?

    public var cellViewModels: [CellViewModel] = [] {
        didSet { reload() }
    }

    public init() { }
}
