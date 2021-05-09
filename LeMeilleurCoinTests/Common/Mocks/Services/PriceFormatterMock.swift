//
//  PriceFormatterMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class PriceFormatterMock: PriceFormatterProtocol {
  
  private(set) var formattedPriceCallsCount: Int = 0
  var formattedPriceListOfParameters: [PriceFormatterParametersProtocol] = []
  var formattedPriceReturnedValue: String?
  
  func formattedPrice(with parameters: PriceFormatterParametersProtocol) -> String {
    formattedPriceCallsCount += 1
    formattedPriceListOfParameters.append(parameters)
    return formattedPriceReturnedValue ?? "\(parameters.price)\(parameters.currencyCode)"
  }
}
