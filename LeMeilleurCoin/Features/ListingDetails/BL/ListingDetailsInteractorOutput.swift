//
//  ListingDetailsInteractorOutput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

enum ListingDetailsCategory {
  case imageUrl(String?)
  case title(String)
  case categoryName(String)
  case price(Float)
  case description(String?)
  case creationDate(Date)
  case siret(String?)
}

protocol ListingDetailsInteractorOutput: AnyObject {
  func setDefaultValues()
  func notifyLoading()
  func notifyEndLoading()
  func notifyNoDataError()
  func notify(categories: [ListingDetailsCategory])
  func notify(isUrgent: Bool)
}
