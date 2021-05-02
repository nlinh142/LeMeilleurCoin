//
//  ListingsInteractorFactoryProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorFactoryProtocol {
  var output: ListingsInteractorOutput? { get set }
  func makeResponse(
    from request: ListingsInteractorFactoryRequest
  ) -> ListingsInteractorFactoryResponse
}


protocol ListingsInteractorFactoryRequest {
  var listingsRepository: ListingsFetching { get }
  var categoryReferentialRepository: CategoryReferentialFetching { get }
  var currentListingRepository: CurrentListingSaving { get }
  var router: ListingsRouting { get }
}

protocol ListingsInteractorFactoryResponse {
  var interactor: ListingsInteractorInput { get }
}
