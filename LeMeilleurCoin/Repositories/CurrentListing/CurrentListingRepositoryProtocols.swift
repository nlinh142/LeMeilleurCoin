//
//  CurrentListingRepositoryProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol CurrentListingFetchingResponse {
  var id: String { get }
  var categoryId: String { get }
  var title: String { get }
  var description: String? { get }
  var price: Float { get }
  var imagesUrl: [String] { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
}

protocol CurrentListingFetching {
  func fetch(completion: @escaping (CurrentListingFetchingResponse?) -> Void)
}
