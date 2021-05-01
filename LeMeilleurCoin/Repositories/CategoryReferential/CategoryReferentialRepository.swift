//
//  CategoryReferentialRepository.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol CategoryReferentialRepositoryDependencies {
  var apiService: APIServiceProtocol { get }
}

final class CategoryReferentialRepository {
  
  // MARK: - Enum
  
  private enum Constants {
    static let urlString: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
  }
  
  // MARK: - Properties
  
  private let apiService: APIServiceProtocol
  
  // MARK: - Init
  
  init(dependencies: CategoryReferentialRepositoryDependencies) {
    apiService = dependencies.apiService
  }
  
  // MARK: - Private
  
  private func fetchingError(from error: Error) -> CategoryReferentialFetchingError {
    switch error {
    case APIError.noData:
      return .noData
    default:
      return .unknown
    }
  }
  
  private func fetchingResponses(from apiResponses: [CategoryReferentialFetchingAPIResponse]) -> [CategoryReferentialFetchingResponse] {
    apiResponses.map {
      CategoryReferentialFetchingResponseModel(id: $0.id, name: $0.name)
    }
  }
}

// MARK: - CategoryReferentialFetching

extension CategoryReferentialRepository: CategoryReferentialFetching {
  func fetch(completion: @escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void) {
    apiService.fetchJsonList(elementType: CategoryReferentialFetchingAPIResponse.self,
                             from: Constants.urlString) { result in
      switch result {
      case let .success(responses):
        completion(.success(self.fetchingResponses(from: responses)))
      case let .failure(error):
        completion(.failure(self.fetchingError(from: error)))
      }
    }
  }
}

// MARK: - CategoryReferentialFetchingResponse

private struct CategoryReferentialFetchingResponseModel: CategoryReferentialFetchingResponse {
  let id: UInt8?
  let name: String?
}

// MARK: - ListingFetchingAPIResponse

private struct CategoryReferentialFetchingAPIResponse: Codable {
  var id: UInt8?
  var name: String?
}
