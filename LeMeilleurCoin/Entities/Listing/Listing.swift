//
//  Listing.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//

import Foundation

enum ListingError: Error {
  case invalid
}

protocol Listing {
  var id: String { get }
  var categoryId: String { get }
  var title: String { get }
  var description: String? { get }
  var price: Float { get }
  var imagesUrl: [String] { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
}

final class AppListing: Listing {
  
  // MARK: - Properties
  
  let id: String
  let categoryId: String
  let title: String
  let description: String?
  let price: Float
  let imagesUrl: [String]
  let creationDate: Date
  let isUrgent: Bool
  
  // MARK: - Init
  
  init(id: String?,
       categoryId: String?,
       title: String?,
       description: String?,
       price: Float?,
       imagesUrl: [String]?,
       creationDate: Date?,
       isUrgent: Bool?) throws {
    guard let id = id,
          let categoryId = categoryId,
          let title = title,
          let price = price,
          let creationDate = creationDate else {
      throw ListingError.invalid
    }
    
    self.id = id
    self.categoryId = categoryId
    self.title = title
    self.price = price
    self.description = description
    self.imagesUrl = imagesUrl ?? []
    self.creationDate = creationDate
    self.isUrgent = isUrgent ?? false
  }
}
