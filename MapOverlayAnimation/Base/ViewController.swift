//
//  ViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import RxSwift

/// Base view controller. Just holds a view model
class ViewController<ViewModelT: ControllerViewModel>: UIViewController {

    let viewModel: ViewModelT

    let disposeBag = DisposeBag()

    required init(viewModel: ViewModelT) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboards are incompatible with truth and beauty")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = viewModel.title
    }
}
