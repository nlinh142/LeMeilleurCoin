//
//  ListingsInteractor.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorDependenciesProtocol {
  var dataSource: ListingsInteractorDataSourceProtocol { get }
}

final class ListingsInteractor {
  
  // MARK: - Properties

  weak var output: ListingsInteractorOutput?

  private var dataSource: ListingsInteractorDataSourceProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingsInteractorDependenciesProtocol) {
    dataSource = dependencies.dataSource
  }

  // MARK: - Private
}

// MARK: - ListingsInteractorInput

extension ListingsInteractor: ListingsInteractorInput {
  func retrieve() {
    DispatchQueue.main.async {
      self.output?.setDefaultValues()
      self.output?.notifyLoading()
    }
  }
}
