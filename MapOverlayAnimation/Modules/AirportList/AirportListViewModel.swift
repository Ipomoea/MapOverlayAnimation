//
//  CityListViewModel.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AirportListViewModel: ReloadableTableViewModel<AirportCellViewModel> {

    enum State: ScreenState {
        case empty
        case loading
        case error
        case content
    }

    let errorViewModel = PlaceholderViewModel(
        title: "Ошибка",
        description: "Что-то пошло не так",
        buttonTitle: "Начать новый поиск"
    )

    let emptyViewModel = PlaceholderViewModel(
        title: "Нет результатов",
        description: "Попробуйте изменить настройки поиска",
        buttonTitle: "Начать новый поиск"
    )

    override var title: String {
        return "Поиск"
    }

    var searchTitle: String {
        return "Поиск по городам или аэропортам"
    }

    var stateDriver: Driver<State> {
        return stateSubject.asDriver(onErrorJustReturn: .error)
    }

    private let stateSubject = BehaviorSubject<State>(value: .empty)

    private let router: AirportRouter
    private let networkService: NetworkService
    private let countryService: CountryService

    private var text = String.empty
    private var cancelable: Cancelable?

    init(router: AirportRouter, networkService: NetworkService, countryService: CountryService) {
        self.router = router
        self.networkService = networkService
        self.countryService = countryService
        super.init()
        updateResults()
    }

    func setText(_ text: String) {
        self.text = text
        updateResults()
    }

    func clearResults() {
        setText(.empty)
    }

    override func selectViewModel(_ cellViewModel: AirportCellViewModel) {
        super.selectViewModel(cellViewModel)
        router.trigger(.map(.withDefaultStartPoint(endPoint: cellViewModel.airport)))
    }

    private func updateResults() {
        cancelable?.cancel()

        if text.isEmpty {
            cellViewModels = []
            stateSubject.onNext(.empty)
            return
        }

        request()
    }

    private func request() {
        stateSubject.onNext(.loading)
        cancelable = networkService
            .getPlaces(from: text, locale: Locale.current.languageCode ?? "en") { [weak self] response in
                guard let self = self else {
                    return
                }

                switch response {
                case .success(let value):
                    self.cellViewModels = self.cellViewModels(from: value)
                    self.stateSubject.onNext(value.isEmpty ? .empty : .content)
                case .failure:
                    self.stateSubject.onNext(.error)
                }

                if case .error = self.countryService.state {
                    self.countryService.requestCountries()
                }
            }
    }

    private func cellViewModels(from airports: AirportList) -> [AirportCellViewModel] {
        return airports.map {
            AirportCellViewModel(airport: $0, countryService: countryService)
        }
    }
}
