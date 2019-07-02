//
//  StateManager.swift
//  Tangerine
//
//  Created by Pavel Lukandiy on 21/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import StatefulViewController

final class StateManager {

    private let stateMachine: ViewStateMachine
    private(set) var currentState: ScreenState = .content

    init(delegate: StateManagerDelegate) {
        self.stateMachine = ViewStateMachine(view: delegate.rootView)
        stateMachine[ScreenState.content] = delegate.contentView
    }
}

extension StateManager {

    func addState(_ state: ScreenState, view: UIView) {
        stateMachine[state.screenName] = view
    }

    func changeState(to newState: ScreenState, animated: Bool = false) {
        stateMachine.transitionToState(.view(newState.screenName), animated: animated, completion: nil)
        currentState = newState
    }
}
