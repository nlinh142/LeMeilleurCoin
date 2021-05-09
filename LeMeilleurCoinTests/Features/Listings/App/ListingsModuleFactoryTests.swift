//
//  ListingsModuleFactoryTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class ListingsModuleFactoryTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingsModuleFactory!
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    let interactorFactory = ListingsInteractorFactoryMock()
    interactorFactory.makeResponseReturnValue = ListingsInteractorFactoryTestResponse(
        interactor: ListingsInteractorInputMock()
    )
    let dependencies = ListingsModuleFactoryTestDependencies(
      interactorFactory: interactorFactory
    )
    sut = ListingsModuleFactory(dependencies: dependencies)
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func test_givenTheModuleFactoryHasBeenInitialized_whenMakeViewController_thenReturnsCorrectInstance() {
    // GIVEN-WHEN
    let viewController = self.sut.makeViewController()
    
    // THEN
    XCTAssertNotNil(viewController)
    XCTAssert(viewController is ListingsViewController)
    XCTAssertNotNil((viewController as? ListingsViewController)?.dependencies.presenter)
  }
}

// MARK: - ListingsInteractorFactoryTestResponse

private struct ListingsInteractorFactoryTestResponse: ListingsInteractorFactoryResponse {
  let interactor: ListingsInteractorInput
}

// MARK: - ListingsModuleFactoryTestDependencies

private struct ListingsModuleFactoryTestDependencies: ListingsModuleFactoryDependencies {
  let interactorFactory: ListingsInteractorFactoryProtocol
}
