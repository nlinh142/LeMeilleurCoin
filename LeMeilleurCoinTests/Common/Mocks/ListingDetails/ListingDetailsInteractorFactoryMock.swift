//
//  ListingDetailsInteractorFactoryMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsInteractorFactoryMock: ListingDetailsInteractorFactoryProtocol {
  
  var output: ListingDetailsInteractorOutput?
  var makeResponseReturnValue: ListingDetailsInteractorFactoryResponse!
  
  func makeResponse(with request: ListingDetailsInteractorFactoryRequest) -> ListingDetailsInteractorFactoryResponse {
    makeResponseReturnValue
  }
}
