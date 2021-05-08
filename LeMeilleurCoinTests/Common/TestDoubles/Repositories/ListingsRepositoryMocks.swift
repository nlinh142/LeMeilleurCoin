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

// MARK: - ListingsFetchingResponseMock

struct ListingsFetchingResponseMock: ListingsFetchingResponse {
  let id: UInt?
  let categoryId: UInt8?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: ListingsFetchingImageUrlsResponse?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?
  
  static func makeStub(id: UInt? = 1234,
                       categoryId: UInt8? = 1,
                       title: String? = "Title",
                       price: Float? = 120.99,
                       creationDate: Date? = .init(timeIntervalSince1970: 123456789)) -> ListingsFetchingResponseMock {
    ListingsFetchingResponseMock(id: id,
                                 categoryId: categoryId,
                                 title: title,
                                 description: "Description",
                                 price: price,
                                 imageUrls: ListingsFetchingImageUrlsResponseMock(small: "small", thumb: "thumb"),
                                 creationDate: creationDate,
                                 isUrgent: false,
                                 siret: "000 111 222")
  }
}

// MARK: - ListingsFetchingImageUrlsResponseMock

struct ListingsFetchingImageUrlsResponseMock: ListingsFetchingImageUrlsResponse {
  let small: String?
  let thumb: String?
}
