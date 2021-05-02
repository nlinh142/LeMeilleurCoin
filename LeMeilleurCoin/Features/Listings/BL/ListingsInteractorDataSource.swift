//
//  ListingsInteractorDataSource.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

final class ListingsInteractorDataSource: ListingsInteractorDataSourceProtocol {
  var listings: [Listing] = []
  var categories: [ListingCategory] = []
  var listingsError: ListingsFetchingError?
  var categoryReferentialError: CategoryReferentialFetchingError?
}
