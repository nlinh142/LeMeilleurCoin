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
    from request: ListingsInteractorFactoryRequestProtocol
  ) -> ListingsInteractorFactoryResponseProtocol
}


protocol ListingsInteractorFactoryRequestProtocol {}

protocol ListingsInteractorFactoryResponseProtocol {
  var interactor: ListingsInteractorInput { get }
}
