//
//  ReloadableTableViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 20.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

class ReloadableTableViewModel<CellViewModel: Hashable & ViewModel>: TableViewModel {

    var reloadAction: VoidClosure?

    var cellViewModels: [CellViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reload()
            }
        }
    }

    var title: String {
        return .empty
    }

    func selectViewModel(_ cellViewModel: CellViewModel) { }
}
