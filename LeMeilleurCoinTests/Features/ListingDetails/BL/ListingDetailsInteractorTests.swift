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
    let dependencies = ListingDetailsInteractorDependenciesMock(
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
      completion(CurrentListingFetchingResponseMock.makeStub(id: nil))
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
      completion(CurrentListingFetchingResponseMock.makeStub(categoryId: nil))
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
      completion(CurrentListingFetchingResponseMock.makeStub())
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
        && self.output.notifyCategoriesReceivedListOfCategories.count == 1
        && self.output.notifyCategoriesReceivedListOfCategories[0].count == 7
        && self.output.notifyCategoriesReceivedListOfCategories[0][0] == .imageUrl("thumb")
        && self.output.notifyCategoriesReceivedListOfCategories[0][1] == .title("Title")
        && self.output.notifyCategoriesReceivedListOfCategories[0][2] == .categoryName("CategoryName")
        && self.output.notifyCategoriesReceivedListOfCategories[0][3] == .price(129.99)
        && self.output.notifyCategoriesReceivedListOfCategories[0][4] == .description("Description")
        && self.output.notifyCategoriesReceivedListOfCategories[0][5] == .creationDate(Date(timeIntervalSince1970: 123456789))
        && self.output.notifyCategoriesReceivedListOfCategories[0][6] == .siret("000 111 222")
        && self.output.notifyIsUrgentCallsCount == 1
        && self.output.notifyIsUrgentReceivedListOfIsUrgent.count == 1
        && self.output.notifyIsUrgentReceivedListOfIsUrgent[0] == false
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

// MARK: - ListingDetailsInteractorDependenciesMock

private struct ListingDetailsInteractorDependenciesMock: ListingDetailsInteractorDependencies {
  let currentListingFetchRepository: CurrentListingFetching
  let currentListingClearRepository: CurrentListingClearing
  let router: ListingDetailsRouting
}
