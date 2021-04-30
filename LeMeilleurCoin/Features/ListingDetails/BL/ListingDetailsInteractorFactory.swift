//
//  ListingDetailsInteractorFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation
import Foundation

final class ListingDetailsInteractorFactory: ListingDetailsInteractorFactoryProtocol {
  
  // MARK: - Properties

  weak var output: ListingDetailsInteractorOutput? {
    didSet {
      interactor?.output = output
    }
  }

  private weak var interactor: ListingDetailsInteractor?

  // MARK: - Lifecycle

  init() {}

  // MARK: - ListingDetailsInteractorInput

  func makeResponse(
    from request: ListingDetailsInteractorFactoryRequestProtocol
  ) -> ListingDetailsInteractorFactoryResponseProtocol {
    let dependencies = ListingDetailsInteractorDependencies()
    let interactor = ListingDetailsInteractor(dependencies: dependencies)
    self.interactor = interactor

    let response = ListingDetailsInteractorFactoryResponse(
      interactor: interactor
    )

    return response
  }
}

// MARK: - ListingDetailsInteractorFactoryResponseProtocol

private struct ListingDetailsInteractorFactoryResponse: ListingDetailsInteractorFactoryResponseProtocol {
  let interactor: ListingDetailsInteractorInput
}

// MARK: - ListingDetailsInteractorDependenciesProtocol

private struct ListingDetailsInteractorDependencies: ListingDetailsInteractorDependenciesProtocol {
}
