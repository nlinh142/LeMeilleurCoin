//
//  AppDateFormatter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol DateFormatterProtocol {
  func string(from date: Date, with formatStyle: DateStyleFormatterProtocol) -> String
  func date(from string: String, with format: String) -> Date?
}

protocol DateStyleFormatterProtocol {
  var dateStyle: AppDateFormatterStyle { get }
  var timeStyle: AppDateFormatterStyle { get }
}

enum AppDateFormatterStyle {
  case none
  case short
  case medium
  case long
  case full
}

final class AppDateFormatter {
  
  // MARK: - Properties

  private let dateFormatter: DateFormatter

  // MARK: - Init
  
  required init(locale: Locale = .current, timeZone: TimeZone = .current) {
    dateFormatter = DateFormatter()
    dateFormatter.locale = locale
  }

  // MARK: - Private

  private func appleDateStyle(fromAppDateStyles AppStyle: AppDateFormatterStyle) -> DateFormatter.Style {
    switch AppStyle {
    case .none:
      return .none
    case .short:
      return .short
    case .medium:
      return .medium
    case .long:
      return .long
    case .full:
      return .full
    }
  }
}

// MARK: - DateFormatterProtocol

extension AppDateFormatter: DateFormatterProtocol {
  func string(from date: Date, with formatStyle: DateStyleFormatterProtocol) -> String {    dateFormatter.dateStyle = appleDateStyle(fromAppDateStyles: formatStyle.dateStyle)
    dateFormatter.timeStyle = appleDateStyle(fromAppDateStyles: formatStyle.timeStyle)
    return dateFormatter.string(from: date)
  }

  func date(from string: String, with format: String) -> Date? {
    dateFormatter.setLocalizedDateFormatFromTemplate(format)
    return dateFormatter.date(from: string)
  }
}
