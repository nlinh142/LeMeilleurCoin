//
//  ListingsRouter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsRouterDependencies {
  var listingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol { get }
}

final class ListingsRouter {

  // MARK: - Properties

  weak var viewController: UIViewController?
  
  private let listingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol
  
  // MARK: - Init
  
  init(dependencies: ListingsRouterDependencies) {
    listingDetailsModuleFactory = dependencies.listingDetailsModuleFactory
  }
}

// MARK: - ListingsRouterProtocol

extension ListingsRouter: ListingsRouterProtocol {
  func routeToListingDetails() {
    let listingDetailsViewController = listingDetailsModuleFactory.makeViewController()
    let navigationController = UINavigationController(rootViewController: listingDetailsViewController)
    navigationController.configure()
    viewController?.present(navigationController, animated: true)
  }
}
