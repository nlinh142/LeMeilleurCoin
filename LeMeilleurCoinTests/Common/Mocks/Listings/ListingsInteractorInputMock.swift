//
//  ListingsInteractorInputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsInteractorInputMock: ListingsInteractorInput {
  
  private(set) var retrieveCallsCount: Int = 0
  
  func retrieve() {
    retrieveCallsCount += 1
  }
  
  private(set) var numberOfCategoriesCallsCount: Int = 0
  var numberOfCategoriesReturnedValue: Int?
  
  func numberOfCategories() -> Int {
    numberOfCategoriesCallsCount += 1
    return numberOfCategoriesReturnedValue ?? 0
  }
  
  private(set) var numberOfItemsCallsCount: Int = 0
  private(set) var numberOfItemsReceivedCategoryIndex: Int?
  var numberOfItemsReturnedValue: Int?
  
  func numberOfItems(for categoryIndex: Int) -> Int {
    numberOfItemsCallsCount += 1
    numberOfItemsReceivedCategoryIndex = categoryIndex
    return numberOfItemsReturnedValue ?? 0
  }
  
  private(set) var itemCallsCount: Int = 0
  var itemListOfArguments: [(Int, Int)] = []
  var itemReturnedValue: ListingItemProtocol?
  
  func item(at index: Int, for categoryIndex: Int) -> ListingItemProtocol? {
    itemCallsCount += 1
    itemListOfArguments.append((index, categoryIndex))
    return itemReturnedValue
  }
  
  private(set) var selectItemCallsCount: Int = 0
  var selectItemListOfArguments: [(index: Int, categoryIndex: Int)] = []
  
  func selectItem(at index: Int, for categoryIndex: Int) {
    selectItemCallsCount += 1
    selectItemListOfArguments.append((index, categoryIndex))
  }
  
  private(set) var selectFiltersCallsCount: Int = 0
  
  func selectFilters() {
    selectFiltersCallsCount += 1
  }
  
  private(set) var selectResetCallsCount: Int = 0
  
  func selectReset() {
    selectResetCallsCount += 1
  }
  
  private(set) var numberOfFiltersCallsCount: Int = 0
  var numberOfFiltersReturnedValue: Int?
  
  func numberOfFilters() -> Int {
    numberOfFiltersCallsCount += 1
    return numberOfFiltersReturnedValue ?? 0
  }
  
  private(set) var filterNameCallsCount: Int = 0
  private(set) var filterNameReceivedIndex: Int?
  var filterNameReturnedValue: String?
  
  func filterName(at index: Int) -> String? {
    filterNameCallsCount += 1
    filterNameReceivedIndex = index
    return filterNameReturnedValue
  }
  
  private(set) var numberOfListingsCallsCount: Int = 0
  private(set) var numberOfListingsReceivedIndex: Int?
  var numberOfListingsReturnedValue: Int?
  
  func numberOfListings(filteredByCategoryAt index: Int) -> Int? {
    numberOfListingsCallsCount += 1
    numberOfListingsReceivedIndex = index
    return numberOfListingsReturnedValue
  }
  
  private(set) var filterCallsCount: Int = 0
  var filterListOfIndexes: [Int] = []
  
  func filter(byCategoryAt index: Int) {
    filterCallsCount += 1
    filterListOfIndexes.append(index)
  }
  
  var noMethodsCalled: Bool {
    retrieveCallsCount == 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount == 0
      && selectFiltersCallsCount == 0
      && selectResetCallsCount == 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount == 0
  }
  
  var retrieveCalledOnly: Bool {
    retrieveCallsCount > 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount == 0
      && selectFiltersCallsCount == 0
      && selectResetCallsCount == 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount == 0
  }
  
  var selectItemCalledOnly: Bool {
    retrieveCallsCount == 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount > 0
      && selectFiltersCallsCount == 0
      && selectResetCallsCount == 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount == 0
  }
  
  var selectFiltersCalledOnly: Bool {
    retrieveCallsCount == 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount == 0
      && selectFiltersCallsCount > 0
      && selectResetCallsCount == 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount == 0
  }
  
  var selectResetCalledOnly: Bool {
    retrieveCallsCount == 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount == 0
      && selectFiltersCallsCount == 0
      && selectResetCallsCount > 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount == 0
  }
  
  var filterCalledOnly: Bool {
    retrieveCallsCount == 0
      && numberOfCategoriesCallsCount == 0
      && numberOfItemsCallsCount == 0
      && itemCallsCount == 0
      && selectItemCallsCount == 0
      && selectFiltersCallsCount == 0
      && selectResetCallsCount == 0
      && numberOfFiltersCallsCount == 0
      && filterNameCallsCount == 0
      && numberOfListingsCallsCount == 0
      && filterCallsCount > 0
  }
}
