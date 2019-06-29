//
//  ViewModel.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

protocol ViewModel: class { }

protocol ControllerViewModel: ViewModel {

    var title: String { get }
}

extension ControllerViewModel {

    var title: String {
        return .empty
    }
}
