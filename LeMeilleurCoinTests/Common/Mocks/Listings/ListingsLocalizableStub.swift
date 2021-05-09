//
//  ListingsLocalizableStub.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

struct ListingsLocalizableStub: ListingsLocalizable {
  var title: String {
    "Toutes"
  }
  
  var filtersButtonTitle: String {
    "Filtres"
  }
  
  var resetButtonTitle: String {
    "Réinitialiser"
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
  
  var noValidListingsTitle: String {
    "Pas de données"
  }
  
  var noValidListingsMessage: String {
    "Aucune annonce valide a été récupérée."
  }
  
  var noValidListingsConfirmationButtonTitle: String {
    "OK"
  }
  
  var filterSelectorTitle: String {
    "Filtrer"
  }
  
  var filterSelectorCancelTitle: String {
    "Annuler"
  }
}
