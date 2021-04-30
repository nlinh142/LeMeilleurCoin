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
    from request: ListingDetailsInteractorFactoryRequestProtocol
  ) -> ListingDetailsInteractorFactoryResponseProtocol
}

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorFactoryRequestProtocol {}

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorFactoryResponseProtocol {
  var interactor: ListingDetailsInteractorInput { get }
}
