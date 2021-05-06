//
//  ListingDetailsRouterAdapter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

final class ListingDetailsRouterAdapter {
  
  // MARK: - Properties
  
  private let router: ListingDetailsRouterProtocol
  
  // MARK: - Init
  
  init(router: ListingDetailsRouterProtocol) {
    self.router = router
  }
}

// MARK: - ListingDetailsRouting

extension ListingDetailsRouterAdapter: ListingDetailsRouting {
  func routeBack() {
    router.routeBack()
  }
}
