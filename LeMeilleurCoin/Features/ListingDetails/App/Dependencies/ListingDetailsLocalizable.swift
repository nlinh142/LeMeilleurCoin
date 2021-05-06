//
//  ListingDetailsLocalizable.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

protocol ListingDetailsLocalizable {
  var title: String { get }
  var fetchingErrorTitle: String { get }
  var fetchingErrorMessage: String { get }
  var fetchingErrorConfirmationButton: String { get }
}
