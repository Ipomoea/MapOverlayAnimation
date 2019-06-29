//
//  Appearance.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 29.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

struct Color {

    private init() { }

    static var titleColor: UIColor {
        return .darkText
    }

    static var descriptionColor: UIColor {
        return .lightGray
    }

    static var grayColor: UIColor {
        return .lightGray
    }

    static var actionColor: UIColor {
        return .blue
    }
}

struct Font {

    private init() { }

    static func font(of size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size)
    }

    static func boldFont(of size: CGFloat) -> UIFont {
        return .boldSystemFont(ofSize: size)
    }

    static func titleFont() -> UIFont {
        return boldFont(of: 18)
    }

    static func descriptionFont() -> UIFont {
        return font(of: 14)
    }
}

extension UIColor {

    static var moa: Color.Type {
        return Color.self
    }
}

extension UIFont {

    static var moa: Font.Type {
        return Font.self
    }
}
