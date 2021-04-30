//
//  CurrentCategoryFilterProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol CurrentCategoryFilterFetchingResponse {
  var selectedCategoryId: String? { get }
}

protocol CurrentCategoryFilterFetching {
  func fetch(completion: @escaping (CurrentCategoryFilterFetchingResponse?) -> Void)
}
