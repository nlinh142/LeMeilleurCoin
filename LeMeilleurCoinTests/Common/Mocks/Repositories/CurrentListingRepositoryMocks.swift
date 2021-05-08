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
  var fetchCompletion: ((@escaping (CurrentListingFetchingResponse?) -> Void) -> Void)?
  
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

// MARK: - CurrentListingFetchingTestResponse

struct CurrentListingFetchingTestResponse: CurrentListingFetchingResponse {
  let id: UInt?
  let category: CurrentListingFetchingCategoryResponse?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: CurrentListingFetchingImageUrlsResponse?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?
  
  static func make(id: UInt? = 1234, categoryId: UInt8? = 1) -> CurrentListingFetchingTestResponse {
    CurrentListingFetchingTestResponse(
      id: id,
      category: CurrentListingFetchingCategoryTestResponse(id: categoryId, name: "CategoryName"),
      title: "Title",
      description: "Description",
      price: 129.99,
      imageUrls: CurrentListingFetchingImageUrlsTestResponse(small: "small", thumb: "thumb"),
      creationDate: Date(timeIntervalSince1970: 123456789),
      isUrgent: false,
      siret: "000 111 222"
    )
  }
}

// MARK: - CurrentListingFetchingCategoryTestResponse

struct CurrentListingFetchingCategoryTestResponse: CurrentListingFetchingCategoryResponse {
  let id: UInt8?
  let name: String?
}

// MARK: - CurrentListingFetchingImageUrlsTestResponse

struct CurrentListingFetchingImageUrlsTestResponse: CurrentListingFetchingImageUrlsResponse {
  let small: String?
  let thumb: String?
}
