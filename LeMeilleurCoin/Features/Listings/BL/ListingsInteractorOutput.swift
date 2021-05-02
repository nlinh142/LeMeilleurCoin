//
//  ListingsInteractorOutput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorOutput: AnyObject {
  func setDefaultValues()
  func notifyLoading()
  func notifyEndLoading()
  func notifyFetchingError()
  func updateListings()
}
