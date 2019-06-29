//
//  ApplicationCoordinator.swift
//  Currencies
//
//  Created by Pavel Lukandiy on 07/05/2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import XCoordinator

enum ApplicationRoute: Route {
    case cities
}

typealias ApplicationRouter = AnyRouter<ApplicationRoute>

final class ApplicationCoordinator: NavigationCoordinator<ApplicationRoute> {

    init() {
        super.init(initialRoute: .cities)
    }

    override func prepareTransition(for route: ApplicationRoute) -> NavigationTransition {
        switch route {
        case .cities:
            let coordinator = AirportCoordinator()
            return .presentOnRoot(coordinator)
        }
    }
}
