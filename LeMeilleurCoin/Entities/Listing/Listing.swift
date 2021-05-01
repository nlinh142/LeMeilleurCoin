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
  var id: UInt { get }
  var categoryId: UInt8 { get }
  var title: String { get }
  var description: String? { get }
  var price: Float { get }
  var imageUrls: ListingImageUrls? { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
}

protocol ListingImageUrls {
  var small: String? { get }
  var thumb: String? { get }
}

protocol AppListingDependencies {
  var id: UInt? { get }
  var categoryId: UInt8? { get }
  var title: String? { get }
  var description: String? { get }
  var price: Float? { get }
  var imageUrls: ListingImageUrls? { get }
  var creationDate: Date? { get }
  var isUrgent: Bool? { get }
}

final class AppListing: Listing {
  
  // MARK: - Properties
  
  let id: UInt
  let categoryId: UInt8
  let title: String
  let description: String?
  let price: Float
  let imageUrls: ListingImageUrls?
  let creationDate: Date
  let isUrgent: Bool
  
  // MARK: - Init
  
  init(dependencies: AppListingDependencies) throws {
    guard let id = dependencies.id,
          let categoryId = dependencies.categoryId,
          let title = dependencies.title,
          !title.isEmpty,
          let price = dependencies.price,
          price > 0,
          let creationDate = dependencies.creationDate else {
      throw ListingError.invalid
    }
    
    self.id = id
    self.categoryId = categoryId
    self.title = title
    self.price = price
    self.description = dependencies.description
    self.imageUrls = dependencies.imageUrls
    self.creationDate = creationDate
    self.isUrgent = dependencies.isUrgent ?? false
  }
}
