//
//  PriceFormatter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol PriceFormatterParametersProtocol {
  var price: Float { get }
  var currencyCode: String { get }
  var fractionDigitsMinMax: FractionDigitsMinMaxProtocol { get }
}

protocol FractionDigitsMinMaxProtocol {
  var minimumFractionDigits: Int { get }
  var maximumFractionDigits: Int { get }
}

protocol PriceFormatterProtocol {
  func formattedPrice(with parameters: PriceFormatterParametersProtocol) -> String
}

final class AppPriceFormatter {
  
  // MARK: - Properties
  
  private lazy var formatter: NumberFormatter = .init()
  
  // MARK: - Init

  init(locale: Locale = .current) {
    formatter.locale = locale
  }
}

// MARK: - PriceFormatterProtocol

extension AppPriceFormatter: PriceFormatterProtocol {
  func formattedPrice(with parameters: PriceFormatterParametersProtocol) -> String {
    formatter.numberStyle = .currency
    formatter.usesGroupingSeparator = true
    formatter.currencyCode = parameters.currencyCode
    formatter.minimumFractionDigits = parameters.fractionDigitsMinMax.minimumFractionDigits
    formatter.maximumFractionDigits = parameters.fractionDigitsMinMax.maximumFractionDigits
    return formatter.string(for: parameters.price) ?? "\(parameters.price)\(parameters.currencyCode)"
  }
}
