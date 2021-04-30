//
//  ListingDetailsPresenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

/// sourcery: AutoMockableAccorHotelsApp
protocol ListingDetailsPresenterDependenciesProtocol {
  var interactor: ListingDetailsInteractorInput { get }
  var stringFormatter: StringFormatterProtocol { get }
  var localizator: ListingDetailsLocalizable { get }
}

final class ListingDetailsPresenter {

  // MARK: - Properties

  weak var output: ListingDetailsPresenterOutput?
  private let interactor: ListingDetailsInteractorInput
  private let stringFormatter: StringFormatterProtocol
  private let localizator: ListingDetailsLocalizable

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    stringFormatter = dependencies.stringFormatter
    localizator = dependencies.localizator
  }
}

// MARK: - ListingDetailsPresenterInput

extension ListingDetailsPresenter: ListingDetailsPresenterInput {
  func viewDidLoad() {
    
  }
}

// MARK: - ListingDetailsInteractorOutput

extension ListingDetailsPresenter: ListingDetailsInteractorOutput {
  func setDefaultValues() {
    
  }

  func notifyLoading() {
    
  }

  func notifyEndLoading() {
    
  }

  func notifyNetworkError() {
    
  }

  func notifyServerError() {
    
  }
  
  func notifyNoDataError() {
    
  }
}
