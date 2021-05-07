//
//  CurrentListing.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

// MARK: - CurrentListingFetchingMock

class CurrentListingFetchingMock: CurrentListingFetching {
  var fetchCallsCount: Int = 0
  var fetchCompletion: ((@escaping (CurrentListingFetchingResponse) -> Void) -> Void)?
  
  func fetch(completion: @escaping (CurrentListingFetchingResponse?) -> Void) {
    fetchCallsCount += 1
    fetchCompletion?(completion)
  }
}

// MARK: - CurrentListingSavingMock

class CurrentListingSavingMock: CurrentListingSaving {
  var saveCallsCount: Int = 0
  var saveReceivedListOfRequests: [CurrentListingSavingRequest] = []
  
  func save(with request: CurrentListingSavingRequest) {
    saveCallsCount += 1
    saveReceivedListOfRequests.append(request)
  }
}

// MARK: - CurrentListingClearingMock

class CurrentListingClearingMock: CurrentListingClearing {
  var clearCallsCount: Int = 0
  
  func clear() {
    clearCallsCount += 1
  }
}
