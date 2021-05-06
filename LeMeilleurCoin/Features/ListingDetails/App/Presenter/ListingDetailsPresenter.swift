//
//  ListingDetailsPresenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

protocol ListingDetailsPresenterDependencies {
  var interactor: ListingDetailsInteractorInput { get }
  var stringFormatter: StringFormatterProtocol { get }
  var dateFormatter: DateFormatterProtocol { get }
  var priceFormatter: PriceFormatterProtocol { get }
  var localizator: ListingDetailsLocalizable { get }
  var assetsProvider: ListingDetailsAssetsProviderProtocol { get }
}

final class ListingDetailsPresenter {

  // MARK: - Enum
  
  private enum Constants {
    // TODO
  }

  // MARK: - Properties

  weak var output: ListingDetailsPresenterOutput?
  private let interactor: ListingDetailsInteractorInput
  private let stringFormatter: StringFormatterProtocol
  private let dateFormatter: DateFormatterProtocol
  private let priceFormatter: PriceFormatterProtocol
  private let localizator: ListingDetailsLocalizable
  private let assetsProvider: ListingDetailsAssetsProviderProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsPresenterDependencies) {
    interactor = dependencies.interactor
    stringFormatter = dependencies.stringFormatter
    dateFormatter = dependencies.dateFormatter
    priceFormatter = dependencies.priceFormatter
    localizator = dependencies.localizator
    assetsProvider = dependencies.assetsProvider
  }
}

// MARK: - ListingDetailsPresenterInput

extension ListingDetailsPresenter: ListingDetailsPresenterInput {
  func viewDidLoad() {
    // TODO
  }
  
  func didTapBackButton() {
    // TODO
  }
  
  func didTapNoDataAlertConfirmationButton() {
    // TODO
  }
}

// MARK: - ListingDetailsInteractorOutput

extension ListingDetailsPresenter: ListingDetailsInteractorOutput {
  func setDefaultValues() {
    // TODO
  }

  func notifyLoading() {
    // TODO
  }

  func notifyEndLoading() {
    // TODO
  }
  
  func notifyNoDataError() {
    // TODO
  }

  func notify(categories: [ListingDetailsCategory]) {
    // TODO
  }
  
  func notify(isUrgent: Bool) {
    // TODO
  }
}
