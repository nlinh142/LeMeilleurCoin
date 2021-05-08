//
//  CategoryReferentialRepositoryMocks.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

// MARK: - CategoryReferentialFetchingMock

class CategoryReferentialFetchingMock: CategoryReferentialFetching {
  var fetchCallsCount: Int = 0
  var fetchCompletion: ((@escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void) -> Void)?
  
  func fetch(completion: @escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void) {
    fetchCallsCount += 1
    fetchCompletion?(completion)
  }
}

// MARK: - CategoryReferentialFetchingResponseMock

struct CategoryReferentialFetchingResponseMock: CategoryReferentialFetchingResponse {
  var id: UInt8?
  var name: String?
  
  static func makeStub(id: UInt8? = 1, name: String? = "Tech") -> CategoryReferentialFetchingResponseMock {
    CategoryReferentialFetchingResponseMock(id: id, name: name)
  }
}
