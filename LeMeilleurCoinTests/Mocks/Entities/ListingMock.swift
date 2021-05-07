//
//  ListingMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

struct ListingMock: Listing {
  let id: UInt
  let categoryId: UInt8
  let title: String
  let description: String?
  let price: Float
  let imageUrls: ListingImageUrls?
  let creationDate: Date
  let isUrgent: Bool
}

struct ListingImageUrlsMock: ListingImageUrls {
  let small: String?
  let thumb: String?
}
