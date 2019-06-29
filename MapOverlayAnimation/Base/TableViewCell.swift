//
//  TableViewCell.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

open class TableViewCell: UITableViewCell {

    override public class var requiresConstraintBasedLayout: Bool { true }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    open func setup() {
        selectionStyle = .none
        addSubviews()
        configureSubviews()
    }

    open func addSubviews() { }

    open func configureSubviews() { }
}
