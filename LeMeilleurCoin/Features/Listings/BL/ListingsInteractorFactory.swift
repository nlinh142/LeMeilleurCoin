//
//  ListingsInteractorFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

final class ListingsInteractorFactory: ListingsInteractorFactoryProtocol {
  
  // MARK: - Properties

  weak var output: ListingsInteractorOutput? {
    didSet {
      interactor?.output = output
    }
  }

  private weak var interactor: ListingsInteractor?

  // MARK: - Lifecycle

  init() {}

  // MARK: - ListingsInteractorInput

  func makeResponse(
    from request: ListingsInteractorFactoryRequestProtocol
  ) -> ListingsInteractorFactoryResponseProtocol {
    let dependencies = ListingsInteractorDependenciesItem(
      dataSource: ListingsInteractorDataSource()
    )
    let interactor = ListingsInteractor(dependencies: dependencies)
    self.interactor = interactor

    let response = ListingsInteractorFactoryResponse(
      interactor: interactor
    )

    return response
  }
}

// MARK: - ListingsInteractorFactoryResponseProtocol

private struct ListingsInteractorFactoryResponse: ListingsInteractorFactoryResponseProtocol {
  let interactor: ListingsInteractorInput
}

// MARK: - ListingsInteractorDependencies

private struct ListingsInteractorDependenciesItem: ListingsInteractorDependencies {
  let dataSource: ListingsInteractorDataSourceProtocol
}
