//
//  ListingDetailsInteractorInputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsInteractorInputMock: ListingDetailsInteractorInput {
  private(set) var retrieveCallsCount: Int = 0
  
  func retrieve() {
    retrieveCallsCount += 1
  }
  
  private(set) var quitCallsCount: Int = 0
  
  func quit() {
    quitCallsCount += 1
  }
  
  private(set) var handleNoDataErrorConfirmationCallsCount: Int = 0
  
  func handleNoDataErrorConfirmation() {
    handleNoDataErrorConfirmationCallsCount += 1
  }
  
  var noMethodsCalled: Bool {
    retrieveCallsCount == 0
      && quitCallsCount == 0
      && handleNoDataErrorConfirmationCallsCount == 0
  }
  
  var retrieveCalledOnly: Bool {
    retrieveCallsCount > 0
      && quitCallsCount == 0
      && handleNoDataErrorConfirmationCallsCount == 0
  }
  
  var quitCalledOnly: Bool {
    retrieveCallsCount == 0
      && quitCallsCount > 0
      && handleNoDataErrorConfirmationCallsCount == 0
  }
  
  var handleNoDataErrorConfirmationCalledOnly: Bool {
    retrieveCallsCount == 0
      && quitCallsCount == 0
      && handleNoDataErrorConfirmationCallsCount > 0
  }
}
