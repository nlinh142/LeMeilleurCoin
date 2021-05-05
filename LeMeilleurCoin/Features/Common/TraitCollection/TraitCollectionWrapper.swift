//
//  TraitCollectionWrapper.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 05/05/2021.
//

import UIKit

enum TraitCollectionWrapperInterfaceSizeClass {
  case compact
  case regular
  case unspecified
}

protocol TraitCollectionWrapperTraitItemProtocol {
  var horizontal: TraitCollectionWrapperInterfaceSizeClass { get }
  var vertical: TraitCollectionWrapperInterfaceSizeClass { get }
}

protocol TraitCollectionWrapperInput {
  var currentTraitCollection: TraitCollectionWrapperTraitItemProtocol { get }
}

protocol TraitCollectionWrapperOutput: AnyObject {
  func traitCollectionDidChange(from previous: TraitCollectionWrapperTraitItemProtocol?,
                                to current: TraitCollectionWrapperTraitItemProtocol)
}

final class TraitCollectionWrapper {

  // MARK: - Properties

  private lazy var notificationCenter = NotificationCenter.default
  weak var output: TraitCollectionWrapperOutput?

  private var currentAppTraitCollection: UITraitCollection? {
    UIApplication.shared.windows.first { $0.isKeyWindow }?.traitCollection
  }

  // MARK: - Lifecycle

  init() {
    notificationCenter.addObserver(self,
                                   selector: #selector(windowTraitCollectionDidChange(notification:)),
                                   name: .windowTraitCollectionDidChange,
                                   object: nil)
  }

  deinit {
    notificationCenter.removeObserver(self,
                                      name: .windowTraitCollectionDidChange,
                                      object: nil)
  }

  // MARK: - Privates

  private func convert(_ sizeClass: UIUserInterfaceSizeClass) -> TraitCollectionWrapperInterfaceSizeClass {
    switch sizeClass {
    case .compact:
      return .compact
    case .regular:
      return .regular
    case .unspecified:
      return .unspecified
    @unknown default:
      return .unspecified
    }
  }

  private func makePreviousWrapperItem(from trait: UITraitCollection?) -> TraitCollectionWrapperTraitItemProtocol? {
    guard let trait = trait else { return nil }

    return makeWrapperItem(from: trait)
  }

  private func makeWrapperItem(from trait: UITraitCollection) -> TraitCollectionWrapperTraitItemProtocol {
    let horizontalSizeClass = convert(trait.horizontalSizeClass)
    let verticalSizeClass = convert(trait.verticalSizeClass)

    return TraitCollectionWrapperTraitItem(horizontal: horizontalSizeClass,
                                           vertical: verticalSizeClass)
  }

  @objc
  private func windowTraitCollectionDidChange(notification: Notification) {
    guard let userInfo = notification.userInfo,
      let currentTrait = userInfo[AppWindow.UserInfoKey.currentTraitCollection] as? UITraitCollection else { return }

    let previousTrait = userInfo[AppWindow.UserInfoKey.previousTraitCollection] as? UITraitCollection
    let previous = makePreviousWrapperItem(from: previousTrait)
    let current = makeWrapperItem(from: currentTrait)

    output?.traitCollectionDidChange(from: previous, to: current)
  }
}

// MARK: - TraitCollectionWrapperInput

extension TraitCollectionWrapper: TraitCollectionWrapperInput {
  var currentTraitCollection: TraitCollectionWrapperTraitItemProtocol {
    guard let currentAppTraitCollection = currentAppTraitCollection else {
      return TraitCollectionWrapperTraitItem(horizontal: .unspecified, vertical: .unspecified)
    }

    return makeWrapperItem(from: currentAppTraitCollection)
  }
}

// MARK: - TraitCollectionWrapperTraitItemProtocol

private struct TraitCollectionWrapperTraitItem: TraitCollectionWrapperTraitItemProtocol {
  let horizontal: TraitCollectionWrapperInterfaceSizeClass
  let vertical: TraitCollectionWrapperInterfaceSizeClass
}
