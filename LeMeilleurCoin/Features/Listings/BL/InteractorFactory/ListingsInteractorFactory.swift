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
  
  // MARK: - ListingsInteractorInput
  
  func makeResponse(
    with request: ListingsInteractorFactoryRequest
  ) -> ListingsInteractorFactoryResponse {
    let dependencies = ListingsInteractorDependenciesModel(
      listingsRepository: request.listingsRepository,
      categoryReferentialRepository: request.categoryReferentialRepository,
      currentListingRepository: request.currentListingRepository,
      router: request.router,
      dataSource: ListingsInteractorDataSource()
    )
    let interactor = ListingsInteractor(dependencies: dependencies)
    self.interactor = interactor
    
    let response = ListingsInteractorFactoryResponseModel(
      interactor: interactor
    )
    
    return response
  }
}

// MARK: - ListingsInteractorFactoryResponse

private struct ListingsInteractorFactoryResponseModel: ListingsInteractorFactoryResponse {
  let interactor: ListingsInteractorInput
}

// MARK: - ListingsInteractorDependencies

private struct ListingsInteractorDependenciesModel: ListingsInteractorDependencies {
  let listingsRepository: ListingsFetching
  let categoryReferentialRepository: CategoryReferentialFetching
  let currentListingRepository: CurrentListingSaving
  let router: ListingsRouting
  let dataSource: ListingsInteractorDataSourceProtocol
}
