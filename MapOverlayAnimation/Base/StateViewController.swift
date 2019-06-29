//
//  StateViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 17.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

class StateViewController<ViewModelT: ControllerViewModel>: ViewController<ViewModelT>, StateManagerDelegate {

    let contentView = UIView()

    var currentState: ScreenState {
        return stateManager.currentState
    }

    private lazy var stateManager = StateManager(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.backgroundColor = .white
        setupContentViewConstraints()
    }

    func setupContentViewConstraints() {
        contentView.pinToSuperview()
    }

    func retry() { }

    func willChangeState(from state: ScreenState, to newState: ScreenState) { }

    func didChangeState(_ newState: ScreenState) { }

    func addState(_ state: ScreenState, view: UIView) {
        stateManager.addState(state, view: view)
    }

    func changeState(to newState: ScreenState, animated: Bool = false) {
        willChangeState(from: currentState, to: newState)
        stateManager.changeState(to: newState, animated: animated)
        didChangeState(newState)
    }
}
