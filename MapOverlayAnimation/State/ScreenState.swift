//
//  ScreenState.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

public typealias ScreenState = String

public extension ScreenState {

    static let content = "content"
    static let loading = "loading"

    var screenName: String {
        return self
    }
}
