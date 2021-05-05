//
//  AppTraitCollectionCenterProtocols.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 05/05/2021.
//

import Foundation

// MARK: - Inputs

enum AppTraitCollectionCenterInterfaceSizeClass {
  case compact
  case regular
  case unspecified
}

protocol AppTraitCollectionCenterHorizontalSizeClassGettable {
  var currentHorizontalSizeClass: AppTraitCollectionCenterInterfaceSizeClass { get }
}

protocol AppTraitCollectionCenterVerticalSizeClassGettable {
  var currentVerticalSizeClass: AppTraitCollectionCenterInterfaceSizeClass { get }
}

protocol AppTraitCollectionCenterSizeClassGettable: AppTraitCollectionCenterHorizontalSizeClassGettable, AppTraitCollectionCenterVerticalSizeClassGettable {
  var currentHorizontalSizeClass: AppTraitCollectionCenterInterfaceSizeClass { get }
  var currentVerticalSizeClass: AppTraitCollectionCenterInterfaceSizeClass { get }
}

// MARK: - Output

protocol AppTraitCollectionCenterOutput: AnyObject {
  func traitCollectionDidChange()
}

protocol AppTraitCollectionCenterSizeClassOutput: AnyObject {
  func traitCollectionSizeClassDidChange()
}

protocol AppTraitCollectionCenterVerticalSizeClassOutput: AnyObject {
  func traitCollectionVerticalSizeClassDidChange()
}

protocol AppTraitCollectionCenterHorizontalSizeClassOutput: AnyObject {
  func traitCollectionHorizontalSizeClassDidChange()
}
