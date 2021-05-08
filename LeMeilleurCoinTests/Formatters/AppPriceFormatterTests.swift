//
//  AppPriceFormatterTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 03/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class AppPriceFormatterTests: XCTestCase {
  
  func test_givenLocaleEnUs_whenFormattedPriceIsCalled_thenReturnPriceInEnUsFormat() {
    // GIVEN
    let sut = AppPriceFormatter(locale: .init(identifier: "en_US"))
    
    let fractionDigits = FractionDigitsMinMax(minimumFractionDigits: 0,
                                              maximumFractionDigits: 0)
    
    let sutParameters = PriceFormatterParameters(price: 10000,
                                                 currencyCode: "EUR",
                                                 fractionDigitsMinMax: fractionDigits)
    
    // WHEN
    let price = sut.formattedPrice(with: sutParameters)
    
    // THEN
    XCTAssertEqual(price, "€10,000")
  }
}

// MARK: - FractionDigitsMinMax

private struct FractionDigitsMinMax: FractionDigitsMinMaxProtocol {
  let minimumFractionDigits: Int
  let maximumFractionDigits: Int
}

// MARK: - PriceFormatterParameters

private struct PriceFormatterParameters: PriceFormatterParametersProtocol {
  let price: Float
  let currencyCode: String
  let fractionDigitsMinMax: FractionDigitsMinMaxProtocol
}

