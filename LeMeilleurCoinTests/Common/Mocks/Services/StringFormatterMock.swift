//
//  StringFormatterMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import UIKit

@testable import LeMeilleurCoin

class StringFormatterMock: StringFormatterProtocol {
  
  private(set) var formatStringCallsCount: Int = 0
  var formatStringListOfArguments: [
    (string: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment)
  ] = []
  var formatStringReturnedValue: NSAttributedString?
  
  func format(string: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> NSAttributedString {
    formatStringCallsCount += 1
    formatStringListOfArguments.append((string, font, textColor, textAlignment))
    return formatStringReturnedValue ?? NSAttributedString(string: string)
  }
}
