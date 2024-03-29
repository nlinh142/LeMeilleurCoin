//
//  ListingsInteractorInput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorInput {
  func retrieve()
  func numberOfCategories() -> Int
  func numberOfItems(for categoryIndex: Int) -> Int
  func item(at index: Int, for categoryIndex: Int) -> ListingItemProtocol?
  func selectItem(at index: Int, for categoryIndex: Int)
  func selectFilters()
  func selectReset()
  func numberOfFilters() -> Int
  func filterName(at index: Int) -> String?
  func numberOfListings(filteredByCategoryAt index: Int) -> Int?
  func filter(byCategoryAt index: Int)
}

protocol ListingItemProtocol {
  var category: String { get }
  var title: String { get }
  var price: Float { get }
  var imageUrl: String? { get }
  var creationDate: Date { get }
  var isUrgent: Bool { get }
}
