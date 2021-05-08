//
//  ListingsInteractorDataSourceProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorDataSourceProtocol {
  var listings: [Listing] { get set }
  var categories: [ListingCategory] { get set }
  var listingsError: ListingsFetchingError? { get set }
  var categoryReferentialError: CategoryReferentialFetchingError? { get set }
  var listingsGroups: [(category: ListingCategory, listings: [Listing])] { get set }
  var selectedCategoryIndex: Int? { get set }
  var currentListings: [Listing] { get set }
}
