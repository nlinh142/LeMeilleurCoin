//
//  ListingDetailsLocalizable.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

protocol ListingDetailsLocalizable {
  var referenceIdDescriptionFormat: String { get }
  var siretDescriptionFormat: String { get }
  var fetchingErrorTitle: String { get }
  var fetchingErrorMessage: String { get }
  var fetchingErrorConfirmationButtonTitle: String { get }
  var closeButtonTitle: String { get }
}
