//
//  ListingDetailsInteractor.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation
import Foundation

/// sourcery: AutoMockableAccorHotelsBusinessLogic
protocol ListingDetailsInteractorDependenciesProtocol {
}

final class ListingDetailsInteractor {
  
  // MARK: - Properties

  weak var output: ListingDetailsInteractorOutput?

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsInteractorDependenciesProtocol) {
  }

  deinit {}

  // MARK: - Private
}

// MARK: - ListingDetailsInteractorInput

extension ListingDetailsInteractor: ListingDetailsInteractorInput {
  func retrieve() {
    
  }
}
