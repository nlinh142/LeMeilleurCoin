//
//  ListingsInteractorTests.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import XCTest

@testable import LeMeilleurCoin

// TODO

class ListingsInteractorTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingsInteractor!
  private var output: ListingsInteractorOutputMock!
  private var listingsRepository: ListingsFetchingMock!
  private var categoryReferentialRepository: CategoryReferentialFetchingMock!
  private var currentListingRepository: CurrentListingSavingMock!
  private var router: ListingsRoutingMock!
  private var dataSource: ListingsInteractorDataSourceMock!
  
  private let timeout: TimeInterval = 1.25
  
  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    listingsRepository = ListingsFetchingMock()
    categoryReferentialRepository = CategoryReferentialFetchingMock()
    currentListingRepository = CurrentListingSavingMock()
    router = ListingsRoutingMock()
    dataSource = ListingsInteractorDataSourceMock()
    let dependencies = ListingsInteractorDependenciesMock(
      listingsRepository: listingsRepository,
      categoryReferentialRepository: categoryReferentialRepository,
      currentListingRepository: currentListingRepository,
      router: router,
      dataSource: dataSource
    )
    sut = ListingsInteractor(dependencies: dependencies)
    
    output = ListingsInteractorOutputMock()
    sut.output = output
  }
  
  override func tearDown() {
    sut = nil
    output = nil
    listingsRepository = nil
    categoryReferentialRepository = nil
    currentListingRepository = nil
    router = nil
    dataSource = nil
    super.tearDown()
  }
  
  // MARK: - Tests
  
  // MARK: retrieve
  
  func test_givenListingsFetchingNoDataError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.failure(.noData))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([CategoryReferentialFetchingResponseMock.makeStub()]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenListingsFetchingUnknownError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.failure(.unknown))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([CategoryReferentialFetchingResponseMock.makeStub()]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenCategoriesFetchingNoDataError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingResponseMock.makeStub()]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.failure(.noData))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenCategoriesFetchingUnknownError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingResponseMock.makeStub()]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.failure(.unknown))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoCategoriesHavingAllMandatoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingResponseMock.makeStub()]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingResponseMock.makeStub(id: nil),
        CategoryReferentialFetchingResponseMock.makeStub(name:nil)
      ]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoListingsHavingAllMandatoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingResponseMock.makeStub(id: nil),
        ListingsFetchingResponseMock.makeStub(categoryId: nil),
        ListingsFetchingResponseMock.makeStub(title: nil),
        ListingsFetchingResponseMock.makeStub(price: nil),
        ListingsFetchingResponseMock.makeStub(creationDate: nil)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([CategoryReferentialFetchingResponseMock.makeStub()]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoListingsHavingValidCategoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingResponseMock.makeStub(categoryId: 100),
        ListingsFetchingResponseMock.makeStub(categoryId: 101)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingResponseMock.makeStub(id: 1),
        CategoryReferentialFetchingResponseMock.makeStub(id: 2),
        CategoryReferentialFetchingResponseMock.makeStub(id: 3)
      ]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 1
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenValidListings_whenRetrieveContent_thenUpdatesListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingResponseMock.makeStub(categoryId: 1),
        ListingsFetchingResponseMock.makeStub(categoryId: 2)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingResponseMock.makeStub(id: 1),
        CategoryReferentialFetchingResponseMock.makeStub(id: 2),
        CategoryReferentialFetchingResponseMock.makeStub(id: 3)
      ]))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 1
        && self.categoryReferentialRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.updateListingsCallsCount == 1
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  // MARK: numberOfCategories
  
  func test_givenValidListingsHaveBeenFetched_whenNumberOfCategoriesIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech")
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456789),
                  isUrgent: false,
                  siret: "222 444 666")
    ]
    
    // WHEN
    let count = sut.numberOfCategories()
    
    // THEN
    XCTAssertEqual(count, 1)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(output.setDefaultValuesCallsCount, 0)
    XCTAssertEqual(output.notifyLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyEndLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyFetchingErrorCallsCount, 0)
    XCTAssertEqual(output.notifyNoValidListingsCallsCount, 0)
    XCTAssertEqual(output.updateListingsCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: numberOfItems
  
  func test_givenValidListingsHaveBeenFetched_whenNumberOfItemsIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456789),
                  isUrgent: false,
                  siret: "111 222 333"),
      ListingMock(id: 13579,
                  categoryId: 2,
                  title: "Title2",
                  description: "Description2",
                  price: 5999.00,
                  imageUrls: ListingImageUrlsMock(small: "small2", thumb: "thumb2"),
                  creationDate: Date(timeIntervalSince1970: 123456790),
                  isUrgent: true,
                  siret: "111 333 555")
    ]
    
    // WHEN
    let count = sut.numberOfItems(for: 0)
    
    // THEN
    XCTAssertEqual(count, 2)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(output.setDefaultValuesCallsCount, 0)
    XCTAssertEqual(output.notifyLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyEndLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyFetchingErrorCallsCount, 0)
    XCTAssertEqual(output.notifyNoValidListingsCallsCount, 0)
    XCTAssertEqual(output.updateListingsCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: item
  
  func test_givenValidListingsHaveBeenFetchedAndInvalidIndexes_whenAnItemIsRequested_thenReturnsNothing() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456791),
                  isUrgent: true,
                  siret: "123 678 345"),
      ListingMock(id: 2222,
                  categoryId: 2,
                  title: "Title2",
                  description: "Description2",
                  price: 5999.00,
                  imageUrls: ListingImageUrlsMock(small: "small2", thumb: "thumb2"),
                  creationDate: Date(timeIntervalSince1970: 1234567989),
                  isUrgent: true,
                  siret: "111 333 555"),
      ListingMock(id: 553125,
                  categoryId: 2,
                  title: "Title3",
                  description: "Description3",
                  price: 3500.00,
                  imageUrls: ListingImageUrlsMock(small: "small3", thumb: "thumb3"),
                  creationDate: Date(timeIntervalSince1970: 123456790),
                  isUrgent: false,
                  siret: "111 222 333")
    ]
    
    // WHEN
    let item = sut.item(at: 200, for: 0)
    
    // THEN
    XCTAssertNil(item)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(output.setDefaultValuesCallsCount, 0)
    XCTAssertEqual(output.notifyLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyEndLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyFetchingErrorCallsCount, 0)
    XCTAssertEqual(output.notifyNoValidListingsCallsCount, 0)
    XCTAssertEqual(output.updateListingsCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndexes_whenAnItemIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456791),
                  isUrgent: true,
                  siret: "444 333 777"),
      ListingMock(id: 2222,
                  categoryId: 2,
                  title: "Title2",
                  description: "Description2",
                  price: 5999.00,
                  imageUrls: ListingImageUrlsMock(small: "small2", thumb: "thumb2"),
                  creationDate: Date(timeIntervalSince1970: 1234567989),
                  isUrgent: true,
                  siret: "111 333 555"),
      ListingMock(id: 553125,
                  categoryId: 2,
                  title: "Title3",
                  description: "Description3",
                  price: 3500.00,
                  imageUrls: ListingImageUrlsMock(small: "small3", thumb: "thumb3"),
                  creationDate: Date(timeIntervalSince1970: 123456790),
                  isUrgent: false,
                  siret: "111 222 333")
    ]
    
    // WHEN
    let item = sut.item(at: 2, for: 0)
    
    // THEN
    XCTAssertNotNil(item)
    XCTAssertEqual(item?.title, "Title3")
    XCTAssertEqual(item?.category, "Vehicles")
    XCTAssertEqual(item?.price, 3500.00)
    XCTAssertEqual(item?.imageUrl, "small3")
    XCTAssertEqual(item?.creationDate, Date(timeIntervalSince1970: 123456790))
    XCTAssertEqual(item?.isUrgent, false)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(output.setDefaultValuesCallsCount, 0)
    XCTAssertEqual(output.notifyLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyEndLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyFetchingErrorCallsCount, 0)
    XCTAssertEqual(output.notifyNoValidListingsCallsCount, 0)
    XCTAssertEqual(output.updateListingsCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: selectItem
  
  func test_givenValidListingsHaveBeenFetchedAndInvalidIndexes_whenAnItemIsSelected_thenNothingHappens() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456791),
                  isUrgent: true,
                  siret: "444 333 777"),
      ListingMock(id: 2222,
                  categoryId: 2,
                  title: "Title2",
                  description: "Description2",
                  price: 5999.00,
                  imageUrls: ListingImageUrlsMock(small: "small2", thumb: "thumb2"),
                  creationDate: Date(timeIntervalSince1970: 1234567989),
                  isUrgent: true,
                  siret: "111 333 555"),
      ListingMock(id: 553125,
                  categoryId: 2,
                  title: "Title3",
                  description: "Description3",
                  price: 3500.00,
                  imageUrls: ListingImageUrlsMock(small: "small3", thumb: "thumb3"),
                  creationDate: Date(timeIntervalSince1970: 123456790),
                  isUrgent: false,
                  siret: "111 222 333")
    ]
    
    // WHEN
    sut.selectItem(at: 200, for: 0)
    
    // THEN
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(output.setDefaultValuesCallsCount, 0)
    XCTAssertEqual(output.notifyLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyEndLoadingCallsCount, 0)
    XCTAssertEqual(output.notifyFetchingErrorCallsCount, 0)
    XCTAssertEqual(output.notifyNoValidListingsCallsCount, 0)
    XCTAssertEqual(output.updateListingsCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndexes_whenAnItemIsSelected_thenRoutesToListingDetails() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = [
      ListingMock(id: 10000,
                  categoryId: 1,
                  title: "Title",
                  description: "Description",
                  price: 120.99,
                  imageUrls: ListingImageUrlsMock(small: "small", thumb: "thumb"),
                  creationDate: Date(timeIntervalSince1970: 123456791),
                  isUrgent: true,
                  siret: nil),
      ListingMock(id: 2222,
                  categoryId: 2,
                  title: "Title2",
                  description: "Description2",
                  price: 5999.00,
                  imageUrls: ListingImageUrlsMock(small: "small2", thumb: "thumb2"),
                  creationDate: Date(timeIntervalSince1970: 1234567989),
                  isUrgent: true,
                  siret: "111 222 333"),
      ListingMock(id: 553125,
                  categoryId: 2,
                  title: "Title3",
                  description: "Description3",
                  price: 3500.00,
                  imageUrls: nil,
                  creationDate: Date(timeIntervalSince1970: 123456790),
                  isUrgent: false,
                  siret: "444 555 666")
    ]
    
    // WHEN
    sut.selectItem(at: 1, for: 0)
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 0
        && self.categoryReferentialRepository.fetchCallsCount == 0
        && self.output.setDefaultValuesCallsCount == 0
        && self.output.notifyLoadingCallsCount == 0
        && self.output.notifyEndLoadingCallsCount == 0
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.updateListingsCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 1
        && self.currentListingRepository.saveReceivedListOfRequests.count == 1
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.category.id == 2
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.category.name == "Vehicles"
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.creationDate == Date(timeIntervalSince1970: 1234567989)
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.price == 5999.00
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.imageUrls?.small == "small2"
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.imageUrls?.thumb == "thumb2"
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.isUrgent == true
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.title == "Title2"
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.description == "Description2"
        && self.currentListingRepository.saveReceivedListOfRequests[safe: 0]?.siret == "444 555 666"
        && self.router.routeToListingDetailsCallsCount == 1
    }
  }
}

// MARK: - ListingsInteractorDependencies

private struct ListingsInteractorDependenciesMock: ListingsInteractorDependencies {
  let listingsRepository: ListingsFetching
  let categoryReferentialRepository: CategoryReferentialFetching
  let currentListingRepository: CurrentListingSaving
  let router: ListingsRouting
  let dataSource: ListingsInteractorDataSourceProtocol
}

// MARK: - ListingsInteractorDataSourceProtocol

private class ListingsInteractorDataSourceMock: ListingsInteractorDataSourceProtocol {
  var listings: [Listing] = []
  var categories: [ListingCategory] = []
  var listingsError: ListingsFetchingError?
  var categoryReferentialError: CategoryReferentialFetchingError?
}
