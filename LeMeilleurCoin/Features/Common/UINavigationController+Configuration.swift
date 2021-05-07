//
//  UINavigationController+Transparent.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 07/05/2021.
//

import UIKit

extension UINavigationController {
  func configure(prefersLargeTitles: Bool = false,
                 isTransparent: Bool = true,
                 tintColor: UIColor = .systemOrange) {
    navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationBar.tintColor = tintColor
    
    if isTransparent {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationBar.shadowImage = UIImage()
      navigationBar.isTranslucent = true
      view.backgroundColor = .clear
    }
  }
}
