//
//  ListingDetailsInteractor.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation
import Foundation

protocol ListingDetailsInteractorDependencies {
  var currentListingFetchRepository: CurrentListingFetching { get }
  var currentListingClearRepository: CurrentListingClearing { get }
  var router: ListingDetailsRouting { get }
}

final class ListingDetailsInteractor {
  
  // MARK: - Properties

  weak var output: ListingDetailsInteractorOutput?
  private let currentListingFetchRepository: CurrentListingFetching
  private let currentListingClearRepository: CurrentListingClearing
  private let router: ListingDetailsRouting

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsInteractorDependencies) {
    currentListingFetchRepository = dependencies.currentListingFetchRepository
    currentListingClearRepository = dependencies.currentListingClearRepository
    router = dependencies.router
  }

  // MARK: - Private
}

// MARK: - ListingDetailsInteractorInput

extension ListingDetailsInteractor: ListingDetailsInteractorInput {
  func retrieve() {
    // TODO
  }
  
  func quit() {
    // TODO
  }
  
  func handleNoDataErrorConfirmation() {
    // TODO
  }
}
