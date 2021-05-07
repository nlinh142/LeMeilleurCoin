//
//  AppDateFormatterTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 03/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class AppDateFormatterTests: XCTestCase {

  // MARK: - Properties
  
  private var sut: AppDateFormatter!

  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    sut = AppDateFormatter(locale: .init(identifier: "en_US"),
                                     timeZone: .init(identifier: "GMT")!)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Tests

  func test_givenMediumAndShortFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .medium, timeStyle: .short)

    let expectedDate = "May 5, 2021 at 3:30 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenMediumAndFullFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .medium, timeStyle: .full)

    let expectedDate = "May 5, 2021 at 3:30:00 PM Greenwich Mean Time"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenMediumAndNoneFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .medium, timeStyle: .none)

    let expectedDate = "May 5, 2021"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenMediumAndMediumFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .medium, timeStyle: .medium)

    let expectedDate = "May 5, 2021 at 3:30:00 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenFullAndShortFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .full, timeStyle: .short)

    let expectedDate = "Wednesday, May 5, 2021 at 3:30 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenLongAndShortFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .long, timeStyle: .short)

    let expectedDate = "May 5, 2021 at 3:30 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenNoneAndShortFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()

    let formatStyles = DateFormatterStylesMock(dateStyle: .none, timeStyle: .short)

    let expectedDate = "3:30 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }

  func test_givenShortAndShortFormatStyles_whenGetStringFromDate_thenReturnExpectedValue() {
    // GIVEN
    let date = Date.makeStub()
    let formatStyles = DateFormatterStylesMock(dateStyle: .short, timeStyle: .short)
    let expectedDate = "5/5/21, 3:30 PM"

    // WHEN
    let formattedDate = sut.string(from: date, with: formatStyles)

    // THEN
    XCTAssertEqual(formattedDate, expectedDate)
  }
  
  func test_givenDateFormat_whenGetDateFromString_thenReturnExpectedValue() {
    // GIVEN
    let dateString = "2019-11-05T15:56:59+0000"
    let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let expectedDate = Date.makeStub(year: 2019, month: 11, day: 5, hour: 15, minute: 56, second: 59)
    
    // WHEN
    let date = sut.date(from: dateString, with: dateFormat)
    
    // THEN
    XCTAssertEqual(date, expectedDate)
  }
}

// MARK: - Date+MakeStub

private extension Date {
  static func makeStub(year: Int = 2021,
                          month: Int = 5,
                          day: Int = 5,
                          hour: Int = 15,
                          minute: Int = 30,
                          second: Int = 0) -> Date {
    var component = DateComponents()
    component.calendar = .init(identifier: .gregorian)
    component.timeZone = .init(identifier: "GMT")
    component.year = year
    component.month = month
    component.day = day
    component.hour = hour
    component.minute = minute
    component.second = second
    return component.date!
  }
}

// MARK: - DateFormatterStylesProtocol

private struct DateFormatterStylesMock: DateFormatterStylesProtocol {
  let dateStyle: DateFormatterStyle
  let timeStyle: DateFormatterStyle
}
