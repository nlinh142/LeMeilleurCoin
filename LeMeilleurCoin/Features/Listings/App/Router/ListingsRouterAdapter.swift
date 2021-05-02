//
//  ListingsRouterAdapter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

final class ListingsRouterAdapter {
  
  // MARK: - Properties
  
  private let router: ListingsRouterProtocol
  
  // MARK: - Init
  
  init(router: ListingsRouterProtocol) {
    self.router = router
  }
}

// MARK: - ListingsRouting

extension ListingsRouterAdapter: ListingsRouting {
  func routeToListingDetails() {
    router.routeToListingDetails()
  }
}
