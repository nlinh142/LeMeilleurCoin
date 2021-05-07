//
//  ListingsInteractorFactoryTests.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import XCTest

@testable import LeMeilleurCoin

class ListingsInteractorFactoryTests: XCTestCase {

  // MARK: - Properties

  private var sut: ListingsInteractorFactory!
  private var output: ListingsInteractorOutputMock!
  private var request: ListingsInteractorFactoryRequestMock!
  
  // MARK: - Setup

  override func setUpWithError() throws {
    sut = ListingsInteractorFactory()
    output = ListingsInteractorOutputMock()
    request = ListingsInteractorFactoryRequestMock(
      listingsRepository: ListingsFetchingMock(),
      categoryReferentialRepository: CategoryReferentialFetchingMock(),
      currentListingRepository: CurrentListingSavingMock(),
      router: ListingsRoutingMock()
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
    XCTAssert(response.interactor is ListingsInteractor)
  }

  func test_givenInteractorResponseHasBeenGenerated_whenConfigureOutput_thenOutputIsSet() {
    // GIVEN
    let response = sut.makeResponse(with: request)

    // WHEN
    sut.output = output

    // THEN
    XCTAssertNotNil((response.interactor as? ListingsInteractor)?.output)
  }
}

// MARK: - ListingsInteractorFactoryRequestMock

private struct ListingsInteractorFactoryRequestMock: ListingsInteractorFactoryRequest {
  let listingsRepository: ListingsFetching
  let categoryReferentialRepository: CategoryReferentialFetching
  let currentListingRepository: CurrentListingSaving
  let router: ListingsRouting
}
