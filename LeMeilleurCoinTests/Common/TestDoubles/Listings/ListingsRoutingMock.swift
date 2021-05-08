//
//  ListingsRoutingMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsRoutingMock: ListingsRouting {
  
  var routeToListingDetailsCallsCount: Int = 0
  
  func routeToListingDetails() {
    routeToListingDetailsCallsCount += 1
  }
}
