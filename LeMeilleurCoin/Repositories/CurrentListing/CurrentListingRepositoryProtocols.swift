//
//  CurrentListingRepositoryProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol CurrentListingSavingRequest {
  var id: UInt { get }
  var categoryId: UInt8 { get }
  var title: String { get }
  var description: String? { get }
  var price: Float { get }
  var imageUrls: CurrentListingSavingImageUrlsRequest? { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
}

protocol CurrentListingSavingImageUrlsRequest {
  var small: String? { get }
  var thumb: String? { get }
}

protocol CurrentListingFetchingResponse {
  var id: UInt? { get }
  var categoryId: UInt8? { get }
  var title: String? { get }
  var description: String? { get }
  var price: Float? { get }
  var imageUrls: CurrentListingFetchingImageUrlsResponse? { get }
  var creationDate: Date? { get }
  var isUrgent: Bool? { get }
}

protocol CurrentListingFetchingImageUrlsResponse {
  var small: String? { get }
  var thumb: String? { get }
}

protocol CurrentListingFetching {
  func fetch(completion: @escaping (CurrentListingFetchingResponse?) -> Void)
}

protocol CurrentListingSaving {
  func save(with request: CurrentListingSavingRequest)
}

protocol CurrentListingClearing {
  func clear()
}
