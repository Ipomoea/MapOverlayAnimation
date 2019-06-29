//
//  ViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

/// Base view controller. Just holds a view model
open class ViewController<ViewModelT: ViewModel>: UIViewController {

    public let viewModel: ViewModelT

    public required init(viewModel: ViewModelT) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboards are incompatible with truth and beauty")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
