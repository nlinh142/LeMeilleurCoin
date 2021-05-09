//
//  ListingDetailsInteractorTests.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import XCTest

@testable import LeMeilleurCoin

class ListingDetailsInteractorTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingDetailsInteractor!
  private var output: ListingDetailsInteractorOutputMock!
  private var currentListingFetchRepository: CurrentListingFetchingMock!
  private var currentListingClearRepository: CurrentListingClearingMock!
  private var router: ListingDetailsRoutingMock!
  
  private let timeout: TimeInterval = 1.25
  
  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    currentListingFetchRepository = CurrentListingFetchingMock()
    currentListingClearRepository = CurrentListingClearingMock()
    router = ListingDetailsRoutingMock()
    let dependencies = ListingDetailsInteractorTestDependencies(
      currentListingFetchRepository: currentListingFetchRepository,
      currentListingClearRepository: currentListingClearRepository,
      router: router
    )
    sut = ListingDetailsInteractor(dependencies: dependencies)
    
    output = ListingDetailsInteractorOutputMock()
    sut.output = output
  }
  
  override func tearDown() {
    sut = nil
    output = nil
    currentListingFetchRepository = nil
    currentListingClearRepository = nil
    router = nil
    super.tearDown()
  }
  
  // MARK: - Tests
  
  // MARK: retrieve
  
  func test_givenNoListingDetails_whenRetrieveContent_thenNotifiesNoDataError() {
    // GIVEN
    currentListingFetchRepository.fetchCompletion = { completion in
      completion(nil)
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingFetchRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoDataErrorCallsCount == 1
        && self.output.notifyCategoriesCallsCount == 0
        && self.output.notifyIsUrgentCallsCount == 0
        && self.currentListingClearRepository.clearCallsCount == 0
        && self.router.routeBackCallsCount == 0
    }
  }
  
  func test_givenListingDetailsNotHavingAllMandatoryInformation_whenRetrieveContent_thenNotifiesNoDataError() {
    // GIVEN
    currentListingFetchRepository.fetchCompletion = { completion in
      completion(CurrentListingFetchingTestResponse.make(id: nil))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingFetchRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoDataErrorCallsCount == 1
        && self.output.notifyCategoriesCallsCount == 0
        && self.output.notifyIsUrgentCallsCount == 0
        && self.currentListingClearRepository.clearCallsCount == 0
        && self.router.routeBackCallsCount == 0
    }
  }
  
  func test_givenListingDetailsNotHavingAllMandatoryCategoryInformation_whenRetrieveContent_thenNotifiesNoDataError() {
    // GIVEN
    currentListingFetchRepository.fetchCompletion = { completion in
      completion(CurrentListingFetchingTestResponse.make(categoryId: nil))
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingFetchRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyNoDataErrorCallsCount == 1
        && self.output.notifyCategoriesCallsCount == 0
        && self.output.notifyIsUrgentCallsCount == 0
        && self.currentListingClearRepository.clearCallsCount == 0
        && self.router.routeBackCallsCount == 0
    }
  }
  
  func test_givenValidListingDetails_whenRetrieveContent_thenNotifiesListingInformation() {
    // GIVEN
    currentListingFetchRepository.fetchCompletion = { completion in
      completion(CurrentListingFetchingTestResponse.make())
    }
    
    // WHEN
    sut.retrieve()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingFetchRepository.fetchCallsCount == 1
        && self.output.setDefaultValuesCallsCount == 1
        && self.output.notifyLoadingCallsCount == 1
        && self.output.notifyEndLoadingCallsCount == 1
        && self.output.notifyCategoriesCallsCount == 1
        && self.output.notifyCategoriesListOfCategories.count == 1
        && self.output.notifyCategoriesListOfCategories[0].count == 8
        && self.output.notifyCategoriesListOfCategories[0][0] == .imageUrl("thumb")
        && self.output.notifyCategoriesListOfCategories[0][1] == .title("Title")
        && self.output.notifyCategoriesListOfCategories[0][2] == .categoryName("CategoryName")
        && self.output.notifyCategoriesListOfCategories[0][3] == .price(129.99)
        && self.output.notifyCategoriesListOfCategories[0][4] == .description("Description")
        && self.output.notifyCategoriesListOfCategories[0][5] == .creationDate(Date(timeIntervalSince1970: 123456789))
        && self.output.notifyCategoriesListOfCategories[0][6] == .siret("000 111 222")
        && self.output.notifyCategoriesListOfCategories[0][7] == .id(1234)
        && self.output.notifyIsUrgentCallsCount == 1
        && self.output.notifyIsUrgentListOfIsUrgent.count == 1
        && self.output.notifyIsUrgentListOfIsUrgent[0] == false
        && self.output.notifyNoDataErrorCallsCount == 0
        && self.currentListingClearRepository.clearCallsCount == 0
        && self.router.routeBackCallsCount == 0
    }
  }
  
  // MARK: - quit
  
  func test_givenListingDetailsHaveBeenFetched_whenQuit_thenRoutesBack() {
    // GIVEN-WHEN
    sut.quit()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingClearRepository.clearCallsCount == 1
        && self.router.routeBackCallsCount == 1
        && self.currentListingFetchRepository.fetchCallsCount == 0
        && self.output.noMethodsCalled
    }
  }
  
  // MARK: - handleNoDataErrorConfirmation
  
  func test_givenListingDetailsHaveBeenFetched_whenhHandleNoDataErrorConfirmation_thenRoutesBack() {
    // GIVEN-WHEN
    sut.quit()
    
    // THEN
    expectation(timeout: timeout) {
      self.currentListingClearRepository.clearCallsCount == 1
        && self.router.routeBackCallsCount == 1
        && self.currentListingFetchRepository.fetchCallsCount == 0
        && self.output.noMethodsCalled
    }
  }
}

// MARK: - ListingDetailsInteractorTestDependencies

private struct ListingDetailsInteractorTestDependencies: ListingDetailsInteractorDependencies {
  let currentListingFetchRepository: CurrentListingFetching
  let currentListingClearRepository: CurrentListingClearing
  let router: ListingDetailsRouting
}
