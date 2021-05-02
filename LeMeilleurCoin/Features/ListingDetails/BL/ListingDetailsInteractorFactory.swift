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
    from request: ListingDetailsInteractorFactoryRequest
  ) -> ListingDetailsInteractorFactoryResponse {
    let dependencies = ListingDetailsInteractorDependenciesModel()
    let interactor = ListingDetailsInteractor(dependencies: dependencies)
    self.interactor = interactor

    let response = ListingDetailsInteractorFactoryResponseModel(
      interactor: interactor
    )

    return response
  }
}

// MARK: - ListingDetailsInteractorFactoryResponse

private struct ListingDetailsInteractorFactoryResponseModel: ListingDetailsInteractorFactoryResponse {
  let interactor: ListingDetailsInteractorInput
}

// MARK: - ListingDetailsInteractorDependencies

private struct ListingDetailsInteractorDependenciesModel: ListingDetailsInteractorDependencies {
}
