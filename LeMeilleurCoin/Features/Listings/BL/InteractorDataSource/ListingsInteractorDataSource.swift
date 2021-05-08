//
//  ListingsInteractorDataSource.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

struct ListingsInteractorDataSource: ListingsInteractorDataSourceProtocol {
  var listings: [Listing] = []
  var categories: [ListingCategory] = []
  var listingsError: ListingsFetchingError?
  var categoryReferentialError: CategoryReferentialFetchingError?
  var listingsGroups: [(category: ListingCategory, listings: [Listing])] = []
  var selectedCategoryIndex: Int?
  var currentListings: [Listing] = []
}
