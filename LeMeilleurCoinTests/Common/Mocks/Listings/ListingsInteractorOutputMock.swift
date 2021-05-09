//
//  ListingsInteractorOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsInteractorOutputMock: ListingsInteractorOutput {
  
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
  
  private(set) var notifyFetchingErrorCallsCount: Int = 0
  
  func notifyFetchingError() {
    notifyFetchingErrorCallsCount += 1
  }
  
  private(set) var notifyNoValidListingsCallsCount: Int = 0
  
  func notifyNoValidListings() {
    notifyNoValidListingsCallsCount += 1
  }
  
  private(set) var updateListingsCallsCount: Int = 0
  var updateListingsListOfArguments: [(categoryName: String?, count: Int?)] = []
  
  func updateListings(categoryName: String?, count: Int?) {
    updateListingsCallsCount += 1
    updateListingsListOfArguments.append((categoryName, count))
  }
  
  private(set) var launchFilterSelectorCallsCount: Int = 0
  
  func launchFilterSelector() {
    launchFilterSelectorCallsCount += 1
  }
  
  var noMethodsCalled: Bool {
    setDefaultValuesCallsCount == 0
      && notifyLoadingCallsCount == 0
      && notifyEndLoadingCallsCount == 0
      && notifyFetchingErrorCallsCount == 0
      && notifyNoValidListingsCallsCount == 0
      && updateListingsCallsCount == 0
      && launchFilterSelectorCallsCount == 0
  }
  
  var launchFilterSelectorCalledOnly: Bool {
    setDefaultValuesCallsCount == 0
      && notifyLoadingCallsCount == 0
      && notifyEndLoadingCallsCount == 0
      && notifyFetchingErrorCallsCount == 0
      && notifyNoValidListingsCallsCount == 0
      && updateListingsCallsCount == 0
      && launchFilterSelectorCallsCount > 0
  }
  
  var updateListingsCalledOnly: Bool {
    setDefaultValuesCallsCount == 0
      && notifyLoadingCallsCount == 0
      && notifyEndLoadingCallsCount == 0
      && notifyFetchingErrorCallsCount == 0
      && notifyNoValidListingsCallsCount == 0
      && updateListingsCallsCount > 0
      && launchFilterSelectorCallsCount == 0
  }
}
