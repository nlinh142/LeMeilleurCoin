//
//  ListingDetailsInteractorFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

final class ListingDetailsInteractorFactory: ListingDetailsInteractorFactoryProtocol {
  
  // MARK: - Properties
  
  weak var output: ListingDetailsInteractorOutput? {
    didSet {
      interactor?.output = output
    }
  }
  
  private weak var interactor: ListingDetailsInteractor?
  
  // MARK: - ListingDetailsInteractorInput
  
  func makeResponse(with request: ListingDetailsInteractorFactoryRequest) -> ListingDetailsInteractorFactoryResponse {
    let dependencies = TestListingDetailsInteractorDependencies(
      currentListingFetchRepository: request.currentListingFetchRepository,
      currentListingClearRepository: request.currentListingClearRepository,
      router: request.router
    )
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

private struct TestListingDetailsInteractorDependencies: ListingDetailsInteractorDependencies {
  let currentListingFetchRepository: CurrentListingFetching
  let currentListingClearRepository: CurrentListingClearing
  let router: ListingDetailsRouting
}
