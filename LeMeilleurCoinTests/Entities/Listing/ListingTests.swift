//
//  ListingTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 29/04/2021.
//

import XCTest
@testable import LeMeilleurCoin

class ListingTests: XCTestCase {
  
  func test_givenNoId_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(id: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenNoCategoryId_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(categoryId: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenNoTitle_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(title: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenEmptyTitle_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(title: "")
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenNoPrice_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(price: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenNegativePrice_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(price: -100.00)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenNoCreationDate_whenInit_thenThrowsError() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make(creationDate: nil)
    
    // WHEN-THEN
    XCTAssertThrowsError(try AppListing(dependencies: dependencies))
  }
  
  func test_givenValidParameters_whenInit_thenAnInstanceIsCreated() {
    // GIVEN
    let dependencies = AppListingDependenciesMock.make()
    
    // WHEN
    let item = try? AppListing(dependencies: dependencies)
    
    // THEN
    XCTAssertNotNil(item)
    XCTAssertEqual(item?.id, 100)
    XCTAssertEqual(item?.categoryId, 1)
    XCTAssertEqual(item?.title, "title")
    XCTAssertEqual(item?.description, "description")
    XCTAssertEqual(item?.price, 100.00)
    XCTAssertEqual(item?.imageUrls?.small, "small")
    XCTAssertEqual(item?.imageUrls?.thumb, "thumb")
    XCTAssertEqual(item?.creationDate, Date(timeIntervalSince1970: 12345678))
    XCTAssertEqual(item?.isUrgent, false)
  }
}

// MARK: - AppListingDependencies

private struct AppListingDependenciesMock: AppListingDependencies {
  let id: UInt?
  let categoryId: UInt8?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: ListingImageUrls?
  let creationDate: Date?
  let isUrgent: Bool?
  
  static func make(id: UInt? = 100,
                   categoryId: UInt8? = 1,
                   title: String? = "title",
                   description: String? = "description",
                   price: Float? = 100.00,
                   imageUrls: ListingImageUrls = ListingImageUrlsMock(small: "small", thumb: "thumb"),
                   creationDate: Date? = Date(timeIntervalSince1970: 12345678),
                   isUrgent: Bool? = false) -> AppListingDependenciesMock {
    AppListingDependenciesMock(id: id,
                               categoryId: categoryId,
                               title: title,
                               description: description,
                               price: price,
                               imageUrls: imageUrls,
                               creationDate: creationDate,
                               isUrgent: isUrgent)
  }
}

// MARK: - ListingImageUrls

private struct ListingImageUrlsMock: ListingImageUrls {
  let small: String?
  let thumb: String?
}
