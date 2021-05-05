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
    let dependencies = ListingsModuleFactoryDependenciesModel(interactorFactory: ListingsInteractorFactory())
    let listingsModuleFactory = ListingsModuleFactory(dependencies: dependencies)
    let viewController = listingsModuleFactory.makeViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    self.window = window
    
    return true
  }
}

// MARK: - ListingsModuleFactoryDependencies

private struct ListingsModuleFactoryDependenciesModel: ListingsModuleFactoryDependencies {
  let interactorFactory: ListingsInteractorFactoryProtocol
}
