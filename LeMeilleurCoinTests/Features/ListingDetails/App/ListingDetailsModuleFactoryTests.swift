//
//  ListingDetailsModuleFactoryTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class ListingDetailsModuleFactoryTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingDetailsModuleFactory!
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    let interactorFactory = ListingDetailsInteractorFactoryMock()
    interactorFactory.makeResponseReturnValue = ListingDetailsInteractorFactoryTestResponse(
        interactor: ListingDetailsInteractorInputMock()
    )
    let dependencies = ListingDetailsModuleFactoryTestDependencies(
      interactorFactory: interactorFactory
    )
    sut = ListingDetailsModuleFactory(dependencies: dependencies)
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_givenTheModuleFactoryHasBeenInitialized_whenMakeViewController_thenReturnsCorrectInstance() {
    // GIVEN-WHEN
    let viewController = self.sut.makeViewController()
    
    // THEN
    XCTAssertNotNil(viewController)
    XCTAssert(viewController is ListingDetailsViewController)
    XCTAssertNotNil((viewController as? ListingDetailsViewController)?.dependencies.presenter)
  }
}

// MARK: - ListingDetailsInteractorFactoryTestResponse

private struct ListingDetailsInteractorFactoryTestResponse: ListingDetailsInteractorFactoryResponse {
  let interactor: ListingDetailsInteractorInput
}

// MARK: - ListingDetailsModuleFactoryTestDependencies

private struct ListingDetailsModuleFactoryTestDependencies: ListingDetailsModuleFactoryDependencies {
  let interactorFactory: ListingDetailsInteractorFactoryProtocol
}
