//
//  TableViewCell.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        addSubviews()
        configureSubviews()
    }

    func addSubviews() { }

    func configureSubviews() { }
}
