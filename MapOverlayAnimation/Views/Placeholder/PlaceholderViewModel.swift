//
//  PlaceholderViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 29.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import RxSwift

final class PlaceholderViewModel: ViewModel {

    let title: String
    let description: String
    let buttonTitle: String

    var actionObservable: Observable<Void> {
        return actionSubject.asObservable()
    }

    private let actionSubject = PublishSubject<Void>()

    init(title: String, description: String, buttonTitle: String) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
    }

    func buttonAction() {
        actionSubject.onNext(())
    }
}
