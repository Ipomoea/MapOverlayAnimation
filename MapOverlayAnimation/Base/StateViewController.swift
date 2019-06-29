//
//  StateViewController.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 17.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

open class StateViewController<ViewModelT: ViewModel>: ViewController<ViewModelT>, StateManagerDelegate {

    public let contentView = UIView()

    public var currentState: ScreenState { stateManager.currentState }

    private lazy var stateManager = StateManager(delegate: self)

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.backgroundColor = .white
        setupContentViewConstraints()
    }

    open func setupContentViewConstraints() {
        contentView.pinToSuperview()
    }

    open func retry() { }

    open func willChangeState(from state: ScreenState, to newState: ScreenState) { }

    open func didChangeState(_ newState: ScreenState) { }

    public func addState(_ state: ScreenState, view: UIView) {
        stateManager.addState(state, view: view)
    }

    public func changeState(to newState: ScreenState, animated: Bool = false) {
        willChangeState(from: currentState, to: newState)
        stateManager.changeState(to: newState, animated: animated)
        didChangeState(newState)
    }
}
