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
  var filtersButtonTitle: String { get }
  var resetButtonTitle: String { get }
  var fetchingErrorTitle: String { get }
  var fetchingErrorMessage: String { get }
  var fetchingErrorConfirmationButtonTitle: String { get }
  var noValidListingsTitle: String { get }
  var noValidListingsMessage: String { get }
  var noValidListingsConfirmationButtonTitle: String { get }
  var filterSelectorTitle: String { get }
  var filterSelectorCancelTitle: String { get }
}
