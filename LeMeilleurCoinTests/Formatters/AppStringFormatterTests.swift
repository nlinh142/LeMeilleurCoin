//
//  AppStringFormatterTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 03/05/2021.
//

import XCTest
import UIKit

@testable import LeMeilleurCoin

class AppStringFormatterTests: XCTestCase {

  // MARK: - Properties

  private var sut: AppStringFormatter!

  // MARK: - Setup

  override func setUpWithError() throws {
    sut = AppStringFormatter()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  // MARK: - Tests
  
  func test_givenTextAttributes_whenTextIsFormatted_thenReturnsExpectedResult() {
    // GIVEN - WHEN
    let formattedString = sut.format(string: "string",
                                           font: .systemFont(ofSize: 15),
                                           textColor: .blue,
                                           textAlignment: .left)
    
    // THEN
    XCTAssertEqual(formattedString.string, "string")
    XCTAssertEqual(formattedString.attribute(.font, at: 0, effectiveRange: nil) as! UIFont,
                   .systemFont(ofSize: 15))
    XCTAssertEqual(formattedString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as! UIColor,
                   .blue)
    XCTAssertEqual((formattedString.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as! NSParagraphStyle).alignment,
                   .left)
  }
}
