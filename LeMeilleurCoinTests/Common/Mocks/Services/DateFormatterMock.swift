//
//  DateFormatterMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class DateFormatterMock: DateFormatterProtocol {
  
  private(set) var stringFromDateWithStyleCallsCount: Int = 0
  var stringFromDateWithStyleListOfArguments: [(date: Date, style: DateFormatterStylesProtocol)] = []
  var stringFromDateWithStyleReturnedValue: String?
  
  func string(from date: Date, with style: DateFormatterStylesProtocol) -> String {
    stringFromDateWithStyleCallsCount += 1
    stringFromDateWithStyleListOfArguments.append((date, style))
    return stringFromDateWithStyleReturnedValue ?? ""
  }
  
  private(set) var dateFromStringWithFormatCallsCount: Int = 0
  var dateFromStringWithFormatListOfArguments: [(string: String, format: String)] = []
  var dateFromStringWithFormatReturnedValue: Date?
  
  func date(from string: String, with format: String) -> Date? {
    dateFromStringWithFormatCallsCount += 1
    dateFromStringWithFormatListOfArguments.append((string, format))
    return dateFromStringWithFormatReturnedValue
  }
  
  var noMethodsCalled: Bool {
    stringFromDateWithStyleCallsCount == 0 && dateFromStringWithFormatCallsCount == 0
  }
  
  var stringFromDateWithStyleCalledOnly: Bool {
    stringFromDateWithStyleCallsCount > 0 && dateFromStringWithFormatCallsCount == 0
  }
  
  var dateFromStringWithFormatCalledOnly: Bool {
    stringFromDateWithStyleCallsCount == 0 && dateFromStringWithFormatCallsCount > 0
  }
}
