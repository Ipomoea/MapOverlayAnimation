//
//  Country.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation

struct Country: Decodable {

    let name: String

    let flag: URL

    let alpha2Code: String

    let alpha3Code: String
}
