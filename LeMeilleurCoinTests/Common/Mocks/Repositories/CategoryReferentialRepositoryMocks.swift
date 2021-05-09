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
  private(set) var fetchCallsCount: Int = 0
  var fetchCompletion: ((@escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void) -> Void)?
  
  func fetch(completion: @escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void) {
    fetchCallsCount += 1
    fetchCompletion?(completion)
  }
}

// MARK: - CategoryReferentialFetchingTestResponse

struct CategoryReferentialFetchingTestResponse: CategoryReferentialFetchingResponse {
  var id: UInt8?
  var name: String?
  
  static func make(id: UInt8? = 1, name: String? = "Tech") -> CategoryReferentialFetchingTestResponse {
    CategoryReferentialFetchingTestResponse(id: id, name: name)
  }
}
