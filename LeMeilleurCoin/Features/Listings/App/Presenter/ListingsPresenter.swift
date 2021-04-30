//
//  ListingsPresenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsPresenterDependenciesProtocol {
  var interactor: ListingsInteractorInput { get }
  var stringFormatter: StringFormatterProtocol { get }
  var localizator: ListingsLocalizable { get }
}

final class ListingsPresenter {

  // MARK: - Properties

  weak var output: ListingsPresenterOutput?
  private let interactor: ListingsInteractorInput
  private let stringFormatter: StringFormatterProtocol
  private let localizator: ListingsLocalizable

  // MARK: - Lifecycle

  init(dependencies: ListingsPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    stringFormatter = dependencies.stringFormatter
    localizator = dependencies.localizator
  }
}

// MARK: - ListingsPresenterInput

extension ListingsPresenter: ListingsPresenterInput {
  func viewDidLoad() {
    
  }
}

// MARK: - ListingsInteractorOutput

extension ListingsPresenter: ListingsInteractorOutput {
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
