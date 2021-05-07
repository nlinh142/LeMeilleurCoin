//
//  XCTestCase+Expectation.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 06/05/2021.
//

import Foundation
import XCTest

extension XCTestCase {
  func expectation(timeout: TimeInterval, file: String = #file, line: Int = #line, error: XCWaitCompletionHandler? = nil, expect: @escaping () -> Bool) {
    let predicate = NSPredicate { _, _ in
      return expect()
    }
    
    let defaultHandler: XCWaitCompletionHandler = { error in
      guard error != nil else { return }
      let issue = XCTIssue(
        type: .assertionFailure,
        compactDescription: "Expectation not fulfilled after \(timeout) seconds.",
        detailedDescription: nil,
        sourceCodeContext: XCTSourceCodeContext(location: .init(filePath: file, lineNumber: line)),
        associatedError: error,
        attachments: []
      )
      self.record(issue)
    }
    
    expectation(for: predicate, evaluatedWith: self, handler: nil)
    waitForExpectations(timeout: timeout, handler: error ?? defaultHandler)
  }
}
