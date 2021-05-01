//
//  CurrentCategoryFilterProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol CurrentCategoryFilterSavingRequest {
  var selectedCategoryId: String { get }
}

protocol CurrentCategoryFilterFetchingResponse {
  var selectedCategoryId: String? { get }
}

protocol CurrentCategoryFilterFetching {
  func fetch(completion: @escaping (CurrentCategoryFilterFetchingResponse?) -> Void)
}

protocol CurrentCategoryFilterSaving {
  func save(with request: CurrentCategoryFilterSavingRequest)
}

protocol CurrentCategoryFilterClearing {
  func clear()
}
