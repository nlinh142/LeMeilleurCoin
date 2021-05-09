//
//  ListingsInteractorTests.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import XCTest

@testable import LeMeilleurCoin

class ListingsInteractorTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingsInteractor!
  private var output: ListingsInteractorOutputMock!
  private var listingsRepository: ListingsFetchingMock!
  private var categoryReferentialRepository: CategoryReferentialFetchingMock!
  private var currentListingRepository: CurrentListingSavingMock!
  private var router: ListingsRoutingMock!
  private var dataSource: ListingsInteractorTestDataSource!
  
  private let timeout: TimeInterval = 1.25
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    listingsRepository = ListingsFetchingMock()
    categoryReferentialRepository = CategoryReferentialFetchingMock()
    currentListingRepository = CurrentListingSavingMock()
    router = ListingsRoutingMock()
    dataSource = ListingsInteractorTestDataSource()
    let dependencies = ListingsInteractorTestDependencies(
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
  
  override func tearDownWithError() throws {
    sut = nil
    output = nil
    listingsRepository = nil
    categoryReferentialRepository = nil
    currentListingRepository = nil
    router = nil
    dataSource = nil
  }
  
  // MARK: - Tests
  
  // MARK: retrieve
  
  func test_givenListingsFetchingNoDataError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.failure(.noData))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([CategoryReferentialFetchingTestResponse.make()]))
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
        && self.output.launchFilterSelectorCallsCount == 0
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
      completion(.success([CategoryReferentialFetchingTestResponse.make()]))
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenCategoriesFetchingNoDataError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingTestResponse.make()]))
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenCategoriesFetchingUnknownError_whenRetrieveContent_thenNotifiesFetchingError() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingTestResponse.make()]))
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoCategoriesHavingAllMandatoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([ListingsFetchingTestResponse.make()]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingTestResponse.make(id: nil),
        CategoryReferentialFetchingTestResponse.make(name:nil)
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoListingsHavingAllMandatoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingTestResponse.make(id: nil),
        ListingsFetchingTestResponse.make(categoryId: nil),
        ListingsFetchingTestResponse.make(title: nil),
        ListingsFetchingTestResponse.make(price: nil),
        ListingsFetchingTestResponse.make(creationDate: nil)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([CategoryReferentialFetchingTestResponse.make()]))
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenNoListingsHavingValidCategoryInformation_whenRetrieveContent_thenNotifiesNoValidListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingTestResponse.make(categoryId: 100),
        ListingsFetchingTestResponse.make(categoryId: 101)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingTestResponse.make(id: 1),
        CategoryReferentialFetchingTestResponse.make(id: 2),
        CategoryReferentialFetchingTestResponse.make(id: 3)
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
        && self.output.launchFilterSelectorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  func test_givenValidListings_whenRetrieveContent_thenUpdatesListings() {
    // GIVEN
    listingsRepository.fetchCompletion = { completion in
      completion(.success([
        ListingsFetchingTestResponse.make(categoryId: 1),
        ListingsFetchingTestResponse.make(categoryId: 2)
      ]))
    }
    
    categoryReferentialRepository.fetchCompletion = { completion in
      completion(.success([
        CategoryReferentialFetchingTestResponse.make(id: 1),
        CategoryReferentialFetchingTestResponse.make(id: 2),
        CategoryReferentialFetchingTestResponse.make(id: 3)
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
        && self.output.updateListingsListOfArguments.count == 1
        && self.output.updateListingsListOfArguments[0].categoryName == nil
        && self.output.updateListingsListOfArguments[0].count == 2
        && self.output.launchFilterSelectorCallsCount == 0
        && self.output.notifyNoValidListingsCallsCount == 0
        && self.output.notifyFetchingErrorCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  // MARK: numberOfCategories
  
  func test_givenValidListingsHaveBeenFetched_whenNumberOfCategoriesIsRequested_thenReturnsCorrectValue() {
    // GIVEN-WHEN
    let count = sut.numberOfCategories()
    
    // THEN
    XCTAssertEqual(count, 1)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: numberOfItems
  
  func test_givenValidListingsHaveBeenFetched_whenNumberOfItemsIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.currentListings = makeListings(categoryIds: [1, 2])
    
    // WHEN
    let count = sut.numberOfItems(for: 0)
    
    // THEN
    XCTAssertEqual(count, 2)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: item
  
  func test_givenValidListingsHaveBeenFetchedAndInvalidIndexes_whenAnItemIsRequested_thenReturnsNothing() {
    // GIVEN
    dataSource.currentListings = makeListings(categoryIds: [1, 2, 2])
    
    // WHEN
    let item = sut.item(at: 200, for: 0)
    
    // THEN
    XCTAssertNil(item)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndexes_whenAnItemIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.currentListings = makeListings(categoryIds: [1, 2, 2])
    
    // WHEN
    let item = sut.item(at: 2, for: 0)
    
    // THEN
    XCTAssertNotNil(item)
    XCTAssertEqual(item?.title, "Title2")
    XCTAssertEqual(item?.category, "Vehicles")
    XCTAssertEqual(item?.price, 200.99)
    XCTAssertEqual(item?.imageUrl, "small2")
    XCTAssertEqual(item?.creationDate, Date(timeIntervalSince1970: 123456789))
    XCTAssertEqual(item?.isUrgent, true)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
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
    
    dataSource.currentListings = makeListings(categoryIds: [1, 2, 2])
    
    // WHEN
    sut.selectItem(at: 200, for: 0)
    
    // THEN
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndexes_whenAnItemIsSelected_thenRoutesToListingDetails() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.currentListings = makeListings(categoryIds: [1, 2, 2])
    
    // WHEN
    sut.selectItem(at: 1, for: 0)
    
    // THEN
    expectation(timeout: timeout) {
      self.listingsRepository.fetchCallsCount == 0
        && self.categoryReferentialRepository.fetchCallsCount == 0
        && self.output.noMethodsCalled
        && self.currentListingRepository.saveCallsCount == 1
        && self.currentListingRepository.saveListOfRequests.count == 1
        && self.currentListingRepository.saveListOfRequests[0].category.id == 2
        && self.currentListingRepository.saveListOfRequests[0].category.name == "Vehicles"
        && self.currentListingRepository.saveListOfRequests[0].creationDate == Date(timeIntervalSince1970: 123456789)
        && self.currentListingRepository.saveListOfRequests[0].price == 100.99
        && self.currentListingRepository.saveListOfRequests[0].imageUrls?.small == "small1"
        && self.currentListingRepository.saveListOfRequests[0].imageUrls?.thumb == "thumb1"
        && self.currentListingRepository.saveListOfRequests[0].isUrgent == true
        && self.currentListingRepository.saveListOfRequests[0].title == "Title1"
        && self.currentListingRepository.saveListOfRequests[0].description == "Description1"
        && self.currentListingRepository.saveListOfRequests[0].siret == "111 222 333"
        && self.router.routeToListingDetailsCallsCount == 1
    }
  }
  
  // MARK: - selectFilters
  
  func test_givenValidListingsHaveBeenFetched_whenSelectFilters_thenLaunchesFilterSelector() {
    // GIVEN-WHEN
    sut.selectFilters()
    
    // THEN
    XCTAssertEqual(output.launchFilterSelectorCallsCount, 1)
    XCTAssert(output.launchFilterSelectorCalledOnly)
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: - selectReset
  
  func test_givenValidListingsHaveBeenFetchedAndNotYetFiltered_whenSelectReset_thenNothingHappens() {
    // GIVEN
    dataSource.selectedCategoryIndex = nil
    
    // WHEN
    sut.selectReset()
    
    // THEN
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndFiltered_whenSelectReset_thenUpdatesListings() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    dataSource.listings = makeListings(categoryIds: [1, 2, 2])
    dataSource.currentListings = makeListings(categoryIds: [1])
    dataSource.selectedCategoryIndex = 1
    
    // WHEN
    sut.selectReset()
    
    // THEN
    expectation(timeout: timeout) {
      self.output.updateListingsCallsCount == 1
        && self.output.updateListingsCalledOnly
        && self.output.updateListingsListOfArguments.count == 1
        && self.output.updateListingsListOfArguments[0].categoryName == nil
        && self.output.updateListingsListOfArguments[0].count == 3
        && self.listingsRepository.fetchCallsCount == 0
        && self.categoryReferentialRepository.fetchCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  // MARK: - numberOfFilters
  
  func test_givenValidListingsHaveBeenFetched_whenNumberOfFiltersIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    // WHEN
    let filtersCount = sut.numberOfFilters()
    
    // THEN
    XCTAssertEqual(filtersCount, 2)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: - filterName
  
  func test_givenValidListingsHaveBeenFetchedAndInvalidIndex_whenFilterNameIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    // WHEN
    let filterName = sut.filterName(at: 10)
    
    // THEN
    XCTAssertNil(filterName)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndex_whenFilterNameIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.categories = [
      ListingCategoryMock(id: 1, name: "Tech"),
      ListingCategoryMock(id: 2, name: "Vehicles"),
    ]
    
    // WHEN
    let filterName = sut.filterName(at: 0)
    
    // THEN
    XCTAssertEqual(filterName, "Tech")
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: - numberOfListings
  
  func test_givenValidListingsHaveBeenFetchedAndInvalidIndex_whenNumberOfListingsOfACategoryIsRequested_thenReturnsNothing() {
    // GIVEN
    dataSource.listingsGroups = [
      (
        ListingCategoryMock(id: 1, name: "Tech"),
        makeListings(categoryIds: [1])
      ),
      (
        ListingCategoryMock(id: 2, name: "Vehicles"),
        makeListings(categoryIds: [2, 2])
      )
    ]
    
    // WHEN
    let listingsCount = sut.numberOfListings(filteredByCategoryAt: 10)
    
    // THEN
    XCTAssertNil(listingsCount)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetchedAndValidIndex_whenNumberOfListingsOfACategoryIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    dataSource.listingsGroups = [
      (
        ListingCategoryMock(id: 1, name: "Tech"),
        makeListings(categoryIds: [1])
      ),
      (
        ListingCategoryMock(id: 2, name: "Vehicles"),
        makeListings(categoryIds: [2, 2])
      )
    ]
    
    // WHEN
    let listingsCount = sut.numberOfListings(filteredByCategoryAt: 1)
    
    // THEN
    XCTAssertEqual(listingsCount, 2)
    
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  // MARK: - filter
  
  func test_givenValidListingsHaveBeenFetched_whenFilterByTheSameCategory_thenNothingHappens() {
    // GIVEN
    dataSource.listingsGroups = [
      (
        ListingCategoryMock(id: 1, name: "Tech"),
        makeListings(categoryIds: [1])
      ),
      (
        ListingCategoryMock(id: 2, name: "Vehicles"),
        makeListings(categoryIds: [2, 2])
      )
    ]
    
    dataSource.currentListings = makeListings(categoryIds: [1])
    dataSource.selectedCategoryIndex = 0
    
    // WHEN
    sut.filter(byCategoryAt: 0)
    
    // THEN
    XCTAssertEqual(listingsRepository.fetchCallsCount, 0)
    XCTAssertEqual(categoryReferentialRepository.fetchCallsCount, 0)
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(currentListingRepository.saveCallsCount, 0)
    XCTAssertEqual(router.routeToListingDetailsCallsCount, 0)
  }
  
  func test_givenValidListingsHaveBeenFetched_whenFilterByAnotherCategory_thenUpdateListings() {
    // GIVEN
    dataSource.listingsGroups = [
      (
        ListingCategoryMock(id: 1, name: "Tech"),
        makeListings(categoryIds: [1])
      ),
      (
        ListingCategoryMock(id: 2, name: "Vehicles"),
        makeListings(categoryIds: [2, 2])
      )
    ]
    
    dataSource.currentListings = makeListings(categoryIds: [1])
    dataSource.selectedCategoryIndex = 0
    
    // WHEN
    sut.filter(byCategoryAt: 1)
    
    // THEN
    expectation(timeout: timeout) {
      self.output.updateListingsCallsCount == 1
        && self.output.updateListingsCalledOnly
        && self.output.updateListingsListOfArguments.count == 1
        && self.output.updateListingsListOfArguments[0].categoryName == "Vehicles"
        && self.output.updateListingsListOfArguments[0].count == 2
        && self.listingsRepository.fetchCallsCount == 0
        && self.categoryReferentialRepository.fetchCallsCount == 0
        && self.currentListingRepository.saveCallsCount == 0
        && self.router.routeToListingDetailsCallsCount == 0
    }
  }
  
  // MARK: - Private
  
  private func makeListings(categoryIds: [UInt8]) -> [ListingMock] {
    var listings: [ListingMock] = []
    
    if categoryIds.isEmpty { return listings }
    
    for i in 0...categoryIds.count - 1 {
      listings.append(ListingMock(id: UInt(i),
                                  categoryId: categoryIds[i],
                                  title: "Title\(i)",
                                  description: "Description\(i)",
                                  price: Float(i) * 100 + 0.99,
                                  imageUrls: ListingImageUrlsMock(small: "small\(i)", thumb: "thumb\(i)"),
                                  creationDate: Date(timeIntervalSince1970: 123456789),
                                  isUrgent: categoryIds[i].isMultiple(of: 2),
                                  siret: "111 222 333"))
    }
    
    return listings
  }
}

// MARK: - ListingsInteractorDependencies

private struct ListingsInteractorTestDependencies: ListingsInteractorDependencies {
  let listingsRepository: ListingsFetching
  let categoryReferentialRepository: CategoryReferentialFetching
  let currentListingRepository: CurrentListingSaving
  let router: ListingsRouting
  let dataSource: ListingsInteractorDataSourceProtocol
}

// MARK: - ListingsInteractorDataSourceProtocol

private class ListingsInteractorTestDataSource: ListingsInteractorDataSourceProtocol {
  var listings: [Listing] = []
  var categories: [ListingCategory] = []
  var listingsError: ListingsFetchingError?
  var categoryReferentialError: CategoryReferentialFetchingError?
  var listingsGroups: [(category: ListingCategory, listings: [Listing])] = []
  var selectedCategoryIndex: Int?
  var currentListings: [Listing] = []
}
