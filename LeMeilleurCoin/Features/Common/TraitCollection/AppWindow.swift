//
//  AppWindow.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 05/05/2021.
//

import UIKit

class AppWindow: UIWindow {
  
  // MARK: - Properties
  
  private lazy var notificationCenter = NotificationCenter.default
  
  // MARK: - Layout
  
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    notificationCenter.post(
      name: Notification.Name.windowTraitCollectionDidChange,
      object: nil,
      userInfo: [
        AppWindow.UserInfoKey.previousTraitCollection: previousTraitCollection,
        AppWindow.UserInfoKey.currentTraitCollection: traitCollection
      ].compactMapValues { $0 }
    )
  }
}

extension AppWindow {
  enum UserInfoKey {
    static let previousTraitCollection = "previousTraitCollection"
    static let currentTraitCollection = "currentTraitCollection"
  }
}

extension Notification.Name {
  static let windowTraitCollectionDidChange = Notification.Name("com.ln.lemeilleurcoin")
}
