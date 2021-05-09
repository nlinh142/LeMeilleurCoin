//
//  ListingDetailsInteractorOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsInteractorOutputMock: ListingDetailsInteractorOutput {
  
  private(set) var setDefaultValuesCallsCount: Int = 0
  
  func setDefaultValues() {
    setDefaultValuesCallsCount += 1
  }
  
  private(set) var notifyLoadingCallsCount: Int = 0
  
  func notifyLoading() {
    notifyLoadingCallsCount += 1
  }
  
  private(set) var notifyEndLoadingCallsCount: Int = 0
  
  func notifyEndLoading() {
    notifyEndLoadingCallsCount += 1
  }
  
  private(set) var notifyNoDataErrorCallsCount: Int = 0
  
  func notifyNoDataError() {
    notifyNoDataErrorCallsCount += 1
  }
  
  private(set) var notifyCategoriesCallsCount: Int = 0
  private(set) var notifyCategoriesListOfCategories: [[ListingDetailsCategory]] = []
  
  func notify(categories: [ListingDetailsCategory]) {
    notifyCategoriesCallsCount += 1
    notifyCategoriesListOfCategories.append(categories)
  }
  
  private(set) var notifyIsUrgentCallsCount: Int = 0
  private(set) var notifyIsUrgentListOfIsUrgent: [Bool] = []
  
  func notify(isUrgent: Bool) {
    notifyIsUrgentCallsCount += 1
    notifyIsUrgentListOfIsUrgent.append(isUrgent)
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
