//
//  Listings.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

// MARK: - ListingsFetchingMock

class ListingsFetchingMock: ListingsFetching {
  var fetchCallsCount: Int = 0
  var fetchCompletion: ((@escaping (Result<[ListingsFetchingResponse], ListingsFetchingError>) -> Void) -> Void)?
  
  func fetch(completion: @escaping (Result<[ListingsFetchingResponse], ListingsFetchingError>) -> Void) {
    fetchCallsCount += 1
    fetchCompletion?(completion)
  }
}

// MARK: - ListingsFetchingTestResponse

struct ListingsFetchingTestResponse: ListingsFetchingResponse {
  let id: UInt?
  let categoryId: UInt8?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: ListingsFetchingImageUrlsResponse?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?
  
  static func make(id: UInt? = 1234,
                   categoryId: UInt8? = 1,
                   title: String? = "Title",
                   price: Float? = 120.99,
                   creationDate: Date? = .init(timeIntervalSince1970: 123456789)) -> ListingsFetchingTestResponse {
    ListingsFetchingTestResponse(id: id,
                                 categoryId: categoryId,
                                 title: title,
                                 description: "Description",
                                 price: price,
                                 imageUrls: ListingsFetchingImageUrlsTestResponse(small: "small", thumb: "thumb"),
                                 creationDate: creationDate,
                                 isUrgent: false,
                                 siret: "000 111 222")
  }
}

// MARK: - ListingsFetchingImageUrlsTestResponse

struct ListingsFetchingImageUrlsTestResponse: ListingsFetchingImageUrlsResponse {
  let small: String?
  let thumb: String?
}
