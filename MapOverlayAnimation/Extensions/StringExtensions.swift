//
//  StringExtensions.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 30.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

extension String {

    static let empty = ""

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
