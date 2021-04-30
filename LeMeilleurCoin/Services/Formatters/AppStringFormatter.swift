//
//  AppStringFormatter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import UIKit

protocol StringFormatterProtocol {
  func format(string: String,
              font: UIFont,
              textColor: UIColor,
              textAlignment: NSTextAlignment) -> NSAttributedString
}

final class AppStringFormatter {}

// MARK: - StringFormatterProtocol

extension AppStringFormatter: StringFormatterProtocol {
  func format(string: String,
              font: UIFont,
              textColor: UIColor,
              textAlignment: NSTextAlignment) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = textAlignment
    
    let attributes: [NSAttributedString.Key : Any] = [
      .font: font,
      .foregroundColor: textColor,
      .paragraphStyle: paragraphStyle
    ]
    
    return NSAttributedString(string: string, attributes: attributes)
  }
}
