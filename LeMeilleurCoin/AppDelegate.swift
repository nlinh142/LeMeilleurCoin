//
//  AppDelegate.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - Properties

  var window: UIWindow?
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let dependencies = ListingsModuleFactoryDependenciesItem(interactorFactory: ListingsInteractorFactory())
    let listingsModuleFactory = ListingsModuleFactory(dependencies: dependencies)
    let viewController = listingsModuleFactory.makeViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}

// MARK: - ListingsModuleFactoryDependencies

private struct ListingsModuleFactoryDependenciesItem: ListingsModuleFactoryDependencies {
  let interactorFactory: ListingsInteractorFactoryProtocol
}
