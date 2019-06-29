//
//  CityListViewController.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

final class AirportListViewController: ReloadableTableViewController<AirportCell, AirportListViewModel> {

    private let searchController = UISearchController(searchResultsController: nil)

    private let emptyView = PlaceholderView()
    private let errorView = PlaceholderView()
    private let loadingView = LoadingView()

    private var searchBar: UISearchBar {
        return searchController.searchBar
    }

    private var isSearchBarActive: Bool {
        return searchBar.isFirstResponder
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addStates()
        setupSearchController()
        bind()
    }

    override func retry() {
        super.retry()

        searchBar.becomeFirstResponder()
        viewModel.clearResults()
    }

    override func configureTableView(tableView: UITableView) {
        super.configureTableView(tableView: tableView)
        tableView.delegate = self
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = viewModel.searchTitle
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func addStates() {
        emptyView.configure(with: viewModel.emptyViewModel)
        errorView.configure(with: viewModel.errorViewModel)

        emptyView.onRetry = retry
        errorView.onRetry = retry

        addState(AirportListViewModel.State.empty.rawValue, view: emptyView)
        addState(AirportListViewModel.State.error.rawValue, view: errorView)
        addState(AirportListViewModel.State.loading.rawValue, view: loadingView)
    }

    private func bind() {
        viewModel.stateDriver
            .map { [weak self] state -> AirportListViewModel.State in
                guard let self = self else {
                    return state
                }

                return self.isSearchBarActive ? .content : state
            }
            .drive(onNext: { [weak self] state in
                guard let self = self else {
                    return
                }

                state == .loading ? self.loadingView.startAnimating() : self.loadingView.stopAnimating()
                self.changeState(to: state.rawValue)
            })
            .disposed(by: disposeBag)

        let textDriver = searchBar.rx.text.asDriver().filterNil()

        searchController.searchBar.rx
            .textDidBeginEditing.asDriver()
            .withLatestFrom(textDriver)
            .filter { $0.isEmpty }
            .drive(onNext: { [weak viewModel] _ in
                viewModel?.clearResults()
            })
            .disposed(by: disposeBag)

        textDriver
            .debounce(.milliseconds(300))
            .drive(onNext: { [weak viewModel] text in
                viewModel?.setText(text)
            })
            .disposed(by: disposeBag)
    }
}
