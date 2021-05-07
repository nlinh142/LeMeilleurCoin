//
//  ListingsLocalizable.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsLocalizable {
  var title: String { get }
  var fetchingErrorTitle: String { get }
  var fetchingErrorMessage: String { get }
  var fetchingErrorConfirmationButton: String { get }
  var noValidListingsTitle: String { get }
  var noValidListingsMessage: String { get }
  var noValidListingsConfirmationButton: String { get }
}
