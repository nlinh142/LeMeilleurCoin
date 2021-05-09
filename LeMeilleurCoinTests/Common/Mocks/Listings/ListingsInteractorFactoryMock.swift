//
//  ListingsInteractorFactoryMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsInteractorFactoryMock: ListingsInteractorFactoryProtocol {
  
  var output: ListingsInteractorOutput?
  var makeResponseReturnValue: ListingsInteractorFactoryResponse!
  
  func makeResponse(with request: ListingsInteractorFactoryRequest) -> ListingsInteractorFactoryResponse {
    makeResponseReturnValue
  }
}
