//
//  ListingDetailsInteractorFactoryProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

protocol ListingDetailsInteractorFactoryProtocol {
  var output: ListingDetailsInteractorOutput? { get set }
  func makeResponse(with request: ListingDetailsInteractorFactoryRequest) -> ListingDetailsInteractorFactoryResponse
}

protocol ListingDetailsInteractorFactoryRequest {
  var currentListingFetchRepository: CurrentListingFetching { get }
  var currentListingClearRepository: CurrentListingClearing { get }
  var router: ListingDetailsRouting { get }
}

protocol ListingDetailsInteractorFactoryResponse {
  var interactor: ListingDetailsInteractorInput { get }
}
