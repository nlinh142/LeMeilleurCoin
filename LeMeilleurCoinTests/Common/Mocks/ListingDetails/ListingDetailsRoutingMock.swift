//
//  ListingDetailsRoutingMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsRoutingMock: ListingDetailsRouting {
  
  var routeBackCallsCount: Int = 0
  
  func routeBack() {
    routeBackCallsCount += 1
  }
}
