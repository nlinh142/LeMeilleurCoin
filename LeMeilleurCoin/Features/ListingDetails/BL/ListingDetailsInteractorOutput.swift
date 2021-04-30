//
//  ListingDetailsInteractorOutput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

enum ListingDetailsCategory {
}

/// sourcery: AutoMockableAccorHotelsBusinessLogicAPI
protocol ListingDetailsInteractorOutput: AnyObject {
  func setDefaultValues()
  func notifyLoading()
  func notifyEndLoading()
  func notifyNoDataError()
  func notifyNetworkError()
  func notifyServerError()
}
