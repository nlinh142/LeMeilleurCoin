//
//  XCTestCase+Gherkin.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 29/04/2021.
//

import Foundation
import XCTest

extension XCTestCase {
  func given(_ description: String, closure: () -> Void) {
    closure()
  }
  
  func when(_ description: String, closure: () -> Void) {
    closure()
  }
  
  func then(_ description: String, closure: () throws -> Void) throws {
    try closure()
  }
}
