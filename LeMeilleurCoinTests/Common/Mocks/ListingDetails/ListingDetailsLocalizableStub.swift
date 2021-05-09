//
//  ListingDetailsLocalizableStub.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

struct ListingDetailsLocalizableStub: ListingDetailsLocalizable {
  var referenceIdDescriptionFormat: String {
    "Ref.: %u"
  }
  
  var siretDescriptionFormat: String {
    "SIRET: %@"
  }
  
  var fetchingErrorTitle: String {
    "Erreur technique"
  }
  
  var fetchingErrorMessage: String {
    "Un problème est survenu."
  }
  
  var fetchingErrorConfirmationButtonTitle: String {
    "OK"
  }
  
  var closeButtonTitle: String {
    "Fermer"
  }
}
