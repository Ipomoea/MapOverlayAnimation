//
//  TableViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

protocol TableViewModel: ControllerViewModel {

    var reloadAction: VoidClosure? { get set }
}

extension TableViewModel {

    func reload() {
        reloadAction?()
    }
}
