//
//  ListingDetailsInteractorFactoryTests.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import XCTest

@testable import LeMeilleurCoin

class ListingDetailsInteractorFactoryTests: XCTestCase {

  // MARK: - Properties

  private var sut: ListingDetailsInteractorFactory!
  private var output: ListingDetailsInteractorOutputMock!
  private var request: ListingDetailsInteractorFactoryRequestMock!
  
  // MARK: - Setup

  override func setUpWithError() throws {
    sut = ListingDetailsInteractorFactory()
    output = ListingDetailsInteractorOutputMock()
    request = ListingDetailsInteractorFactoryRequestMock(
      currentListingFetchRepository: CurrentListingFetchingMock(),
      currentListingClearRepository: CurrentListingClearingMock(),
      router: ListingDetailsRoutingMock()
    )
  }

  override func tearDownWithError() throws {
    sut = nil
    output = nil
    request = nil
  }
  
  // MARK: - Tests

  func test_givenDependenciesAreAllSet_whenMakeResponse_thenReturnsCorrectResponse() {
    // GIVEN-WHEN
    let response = sut.makeResponse(with: request)
    
    // THEN
    XCTAssert(response.interactor is ListingDetailsInteractor)
  }

  func test_givenInteractorResponseHasBeenGenerated_whenConfigureOutput_thenOutputIsSet() {
    // GIVEN
    let response = sut.makeResponse(with: request)

    // WHEN
    sut.output = output

    // THEN
    XCTAssertNotNil((response.interactor as? ListingDetailsInteractor)?.output)
  }
}

// MARK: - ListingDetailsInteractorFactoryRequestMock

private struct ListingDetailsInteractorFactoryRequestMock: ListingDetailsInteractorFactoryRequest {
  let currentListingFetchRepository: CurrentListingFetching
  let currentListingClearRepository: CurrentListingClearing
  let router: ListingDetailsRouting
}
