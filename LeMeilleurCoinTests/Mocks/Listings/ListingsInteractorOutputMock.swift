//
//  ListingsInteractorOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsInteractorOutputMock: ListingsInteractorOutput {
  
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
  
  var notifyFetchingErrorCallsCount: Int = 0
  
  func notifyFetchingError() {
    notifyFetchingErrorCallsCount += 1
  }
  
  var notifyNoValidListingsCallsCount: Int = 0
  
  func notifyNoValidListings() {
    notifyNoValidListingsCallsCount += 1
  }
  
  var updateListingsCallsCount: Int = 0
  
  func updateListings() {
    updateListingsCallsCount += 1
  }
}
