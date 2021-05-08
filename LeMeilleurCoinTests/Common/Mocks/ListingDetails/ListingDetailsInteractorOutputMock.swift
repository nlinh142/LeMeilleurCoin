//
//  ListingDetailsInteractorOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsInteractorOutputMock: ListingDetailsInteractorOutput {
  
  var setDefaultValuesCallsCount: Int = 0
  
  func setDefaultValues() {
    setDefaultValuesCallsCount += 1
  }
  
  var notifyLoadingCallsCount: Int = 0
  
  func notifyLoading() {
    notifyLoadingCallsCount += 1
  }
  
  var notifyEndLoadingCallsCount: Int = 0
  
  func notifyEndLoading() {
    notifyEndLoadingCallsCount += 1
  }
  
  var notifyNoDataErrorCallsCount: Int = 0
  
  func notifyNoDataError() {
    notifyNoDataErrorCallsCount += 1
  }
  
  var notifyCategoriesCallsCount: Int = 0
  var notifyCategoriesReceivedListOfCategories: [[ListingDetailsCategory]] = []
  
  func notify(categories: [ListingDetailsCategory]) {
    notifyCategoriesCallsCount += 1
    notifyCategoriesReceivedListOfCategories.append(categories)
  }
  
  var notifyIsUrgentCallsCount: Int = 0
  var notifyIsUrgentReceivedListOfIsUrgent: [Bool] = []
  
  func notify(isUrgent: Bool) {
    notifyIsUrgentCallsCount += 1
    notifyIsUrgentReceivedListOfIsUrgent.append(isUrgent)
  }
  
  var noMethodsCalled: Bool {
    setDefaultValuesCallsCount == 0
      && notifyLoadingCallsCount == 0
      && notifyEndLoadingCallsCount == 0
      && notifyNoDataErrorCallsCount == 0
      && notifyCategoriesCallsCount == 0
      && notifyIsUrgentCallsCount == 0
  }
}
