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
  var id: UInt8? { get }
  var name: String? { get }
}

protocol CategoryReferentialFetching {
  func fetch(completion: @escaping (Result<[CategoryReferentialFetchingResponse], CategoryReferentialFetchingError>) -> Void)
}
