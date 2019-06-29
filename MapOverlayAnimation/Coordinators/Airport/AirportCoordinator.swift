//
//  AirportCoordinator.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import XCoordinator

enum AirportRoute: Route {
    case list
    case map(Airport)
}

typealias AirportRouter = AnyRouter<AirportRoute>

final class AirportCoordinator: NavigationCoordinator<AirportRoute> {

    private let storage = AirportCoordinatorStorage()

    init() {
        super.init(initialRoute: .list)
    }

    override func prepareTransition(for route: AirportRoute) -> NavigationTransition {
        switch route {
        case .list:
            let viewModel = AirportListViewModel(
                router: anyRouter,
                networkService: storage.networkService,
                countryService: storage.countryService
            )
            let viewController = AirportListViewController(viewModel: viewModel)
            return .push(viewController)
        case .map(let airport):
            let viewModel = FlightMapViewModel(airport: airport)
            let viewController = FlightMapViewController(viewModel: viewModel)
            return .push(viewController)
        }
    }
}
