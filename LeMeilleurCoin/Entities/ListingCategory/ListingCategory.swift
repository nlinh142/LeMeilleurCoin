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
  var id: UInt { get }
  var name: String { get }
}

protocol AppListingCategoryDependencies {
  var id: UInt? { get }
  var name: String? { get }
}

final class AppListingCategory {
  
  // MARK: - Properties
  
  let id: UInt
  let name: String
  
  // MARK: - Init
  
  init(dependencies: AppListingCategoryDependencies) throws {
    guard let id = dependencies.id,
          let name = dependencies.name,
          !name.isEmpty else {
      throw ListingCategoryError.invalid
    }
    
    self.id = id
    self.name = name
  }
}
