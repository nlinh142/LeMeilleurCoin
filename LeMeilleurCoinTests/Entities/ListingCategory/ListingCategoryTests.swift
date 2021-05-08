//
//  ListingCategoryTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 29/04/2021.
//

import XCTest

@testable import LeMeilleurCoin

class ListingCategoryTests: XCTestCase {
  
  func test_givenNoId_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingCategoryTestDependencies(id: nil, name: "name")
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListingCategory(dependencies: dependencies))
  }
  
  func test_givenNoName_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingCategoryTestDependencies(id: 1, name: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListingCategory(dependencies: dependencies))
  }
  
  func test_givenEmptyName_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingCategoryTestDependencies(id: 1, name: "")
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListingCategory(dependencies: dependencies))
  }
  
  func test_givenValidIdAndValidName_whenInit_thenAnInstanceIsCreated() {
    // GIVEN
    let dependencies = AppListingCategoryTestDependencies(id: 1, name: "name")
    
    // WHEN
    let item = try? AppListingCategory(dependencies: dependencies)
    
    // THEN
    XCTAssertNotNil(item)
    XCTAssertEqual(item?.id, 1)
    XCTAssertEqual(item?.name, "name")
  }
}

// MARK: - AppListingCategoryDependencies

private struct AppListingCategoryTestDependencies: AppListingCategoryDependencies {
  let id: UInt8?
  let name: String?
}
