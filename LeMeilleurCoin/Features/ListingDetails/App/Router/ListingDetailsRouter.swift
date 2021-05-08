//
//  ListingDetailsRouter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

final class ListingDetailsRouter {
  
  // MARK: - Properties
  
  weak var viewController: UIViewController?
}

// MARK: - ListingDetailsRouterProtocol

extension ListingDetailsRouter: ListingDetailsRouterProtocol {
  func routeBack() {
    viewController?.dismiss(animated: true, completion: nil)
  }
}
