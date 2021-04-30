//
//  CategoryReferentialFetching.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

enum CategoryReferentialFetchingError: Error {
  case noData
  case unknown
}

protocol CategoryReferentialFetchingResponse {
  var id: String? { get }
  var name: String? { get }
}

protocol CategoryReferentialFetching {
  func fetch(success: @escaping ([CategoryReferentialFetchingResponse]) -> Void,
             failure: @escaping (CategoryReferentialFetchingError) -> Void)
}
