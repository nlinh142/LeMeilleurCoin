//
//  ListingDetailsInteractorFactoryProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorFactoryProtocol {
  var output: ListingDetailsInteractorOutput? { get set }
  func makeResponse(
    from request: ListingDetailsInteractorFactoryRequest
  ) -> ListingDetailsInteractorFactoryResponse
}

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorFactoryRequest {}

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorFactoryResponse {
  var interactor: ListingDetailsInteractorInput { get }
}
