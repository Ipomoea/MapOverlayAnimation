//
//  UIApplicationExtensions.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

extension UIApplication {

    var applicationName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
}
