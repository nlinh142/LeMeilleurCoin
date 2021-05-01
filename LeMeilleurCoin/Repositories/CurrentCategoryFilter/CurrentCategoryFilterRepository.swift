//
//  CurrentCategoryFilterRepository.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

final class CurrentCategoryFilterRepository {
  
  // MARK: - Properties
  
  static let shared: CurrentCategoryFilterRepository = .init()
  
  private var response: CurrentCategoryFilterFetchingResponse?
  
  // MARK: - Init
  
  private init() {}
}

// MARK: - CurrentCategoryFilterFetching

extension CurrentCategoryFilterRepository: CurrentCategoryFilterFetching {
  func fetch(completion: @escaping (CurrentCategoryFilterFetchingResponse?) -> Void) {
    completion(response)
  }
}

// MARK: - CurrentCategoryFilterSaving

extension CurrentCategoryFilterRepository: CurrentCategoryFilterSaving {
  func save(with request: CurrentCategoryFilterSavingRequest) {
    response = CurrentCategoryFilterFetchingResponseModel(selectedCategoryId: request.selectedCategoryId)
  }
}

// MARK: - CurrentCategoryFilterClearing

extension CurrentCategoryFilterRepository: CurrentCategoryFilterClearing {
  func clear() {
    response = nil
  }
}

// MARK: - CurrentCategoryFilterFetchingResponse

private struct CurrentCategoryFilterFetchingResponseModel: CurrentCategoryFilterFetchingResponse {
  let selectedCategoryId: String?
}
