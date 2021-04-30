//
//  ListingCategory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//

import Foundation

enum ListingCategoryError: Error {
  case invalid
}

protocol ListingCategory {
  var id: String { get }
  var name: String { get }
}

final class AppListingCategory {
  
  // MARK: - Properties
  
  let id: String
  let name: String
  
  // MARK: - Init
  
  init(id: String?,
       name: String?) throws {
    guard let id = id,
          let name = name else {
      throw ListingCategoryError.invalid
    }
    
    self.id = id
    self.name = name
  }
}
