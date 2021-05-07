//
//  ListingsRepositoryProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

enum ListingsFetchingError: Error {
  case noData
  case unknown
}

protocol ListingsFetchingResponse {
  var id: UInt? { get }
  var categoryId: UInt8? { get }
  var title: String? { get }
  var description: String? { get }
  var price: Float? { get }
  var imageUrls: ListingsFetchingImageUrlsResponse? { get }
  var creationDate: Date? { get }
  var isUrgent: Bool? { get }
  var siret: String? { get }
}

protocol ListingsFetchingImageUrlsResponse {
  var small: String? { get }
  var thumb: String? { get }
}

protocol ListingsFetching {
  func fetch(completion: @escaping (Result<[ListingsFetchingResponse], ListingsFetchingError>) -> Void)
}
