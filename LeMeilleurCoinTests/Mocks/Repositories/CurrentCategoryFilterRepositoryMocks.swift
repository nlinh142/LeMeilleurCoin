//
//  CurrentCategoryFilterRepositoryMocks.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

struct CurrentCategoryFilterSavingRequestMock: CurrentCategoryFilterSavingRequest {
  var selectedCategoryId: String
}

struct CurrentCategoryFilterFetchingResponseMock: CurrentCategoryFilterFetchingResponse {
  var selectedCategoryId: String?
}

// MARK: - CurrentCategoryFilterFetchingMock

class CurrentCategoryFilterFetchingMock: CurrentCategoryFilterFetching {
  var fetchCallsCount: Int = 0
  var fetchCompletion: ((@escaping (CurrentCategoryFilterFetchingResponse?) -> Void) -> Void)?
  
  func fetch(completion: @escaping (CurrentCategoryFilterFetchingResponse?) -> Void) {
    fetchCallsCount += 1
    fetchCompletion?(completion)
  }
}

// MARK: - CurrentCategoryFilterSavingMock

class CurrentCategoryFilterSavingMock: CurrentCategoryFilterSaving {
  var saveCallsCount: Int = 0
  var saveReceivedListOfRequests: [CurrentCategoryFilterSavingRequest] = []
  
  func save(with request: CurrentCategoryFilterSavingRequest) {
    saveCallsCount += 1
    saveReceivedListOfRequests.append(request)
  }
}

// MARK: - CurrentCategoryFilterClearingMock

class CurrentCategoryFilterClearingMock: CurrentCategoryFilterClearing {
  var clearCallsCount: Int = 0
  
  func clear() {
    clearCallsCount += 1
  }
}

