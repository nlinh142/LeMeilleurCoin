//
//  AppTraitCollectionCenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 05/05/2021.
//

import Foundation

final class AppTraitCollectionCenter {

  // MARK: - Properties

  weak var output: AppTraitCollectionCenterOutput?
  weak var sizeClassOutput: AppTraitCollectionCenterSizeClassOutput?
  weak var horizontalSizeClassOutput: AppTraitCollectionCenterHorizontalSizeClassOutput?
  weak var verticalSizeClassOutput: AppTraitCollectionCenterVerticalSizeClassOutput?

  private let wrapper: TraitCollectionWrapperInput

  // MARK: - Lifecycle

  init(wrapper: TraitCollectionWrapperInput) {
    self.wrapper = wrapper
  }

  // MARK: - Private

  private func convert(_ sizeClass: TraitCollectionWrapperInterfaceSizeClass) -> AppTraitCollectionCenterInterfaceSizeClass {
    switch sizeClass {
    case .compact:
      return .compact
    case .regular:
      return .regular
    case .unspecified:
      return .unspecified
    }
  }

  private func notifyAllChanges() {
    notifySizeClassChanges()
    output?.traitCollectionDidChange()
  }

  private func notifySizeClassChanges() {
    verticalSizeClassOutput?.traitCollectionVerticalSizeClassDidChange()
    horizontalSizeClassOutput?.traitCollectionHorizontalSizeClassDidChange()
    sizeClassOutput?.traitCollectionSizeClassDidChange()
  }
}

// MARK: - AppTraitCollectionCenterHorizontalSizeClassGettable

extension AppTraitCollectionCenter: AppTraitCollectionCenterHorizontalSizeClassGettable {
  var currentHorizontalSizeClass: AppTraitCollectionCenterInterfaceSizeClass {
    convert(wrapper.currentTraitCollection.horizontal)
  }
}

// MARK: - AppTraitCollectionCenterVerticalSizeClassGettable

extension AppTraitCollectionCenter: AppTraitCollectionCenterVerticalSizeClassGettable {
  var currentVerticalSizeClass: AppTraitCollectionCenterInterfaceSizeClass {
    convert(wrapper.currentTraitCollection.vertical)
  }
}

// MARK: - AppTraitCollectionCenterSizeClassGettable

extension AppTraitCollectionCenter: AppTraitCollectionCenterSizeClassGettable {}

// MARK: - TraitCollectionWrapperOutput

extension AppTraitCollectionCenter: TraitCollectionWrapperOutput {
  func traitCollectionDidChange(from previous: TraitCollectionWrapperTraitItemProtocol?,
                                to current: TraitCollectionWrapperTraitItemProtocol) {
    guard let previous = previous else {
      notifyAllChanges()
      return
    }

    let didHorizontalSizeClassChange = previous.horizontal != current.horizontal
    let didVerticalSizeClassChange = previous.vertical != current.vertical

    switch (didHorizontalSizeClassChange, didVerticalSizeClassChange) {
    case (true, false):
      horizontalSizeClassOutput?.traitCollectionHorizontalSizeClassDidChange()
      sizeClassOutput?.traitCollectionSizeClassDidChange()
    case (false, true):
      verticalSizeClassOutput?.traitCollectionVerticalSizeClassDidChange()
      sizeClassOutput?.traitCollectionSizeClassDidChange()
    case (true, true):
      notifySizeClassChanges()
    case (false, false):
      break
    }

    output?.traitCollectionDidChange()
  }
}
