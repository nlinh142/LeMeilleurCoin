//
//  ListingsModuleFactoryProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 08/05/2021.
//

import UIKit

protocol ListingsModuleFactoryProtocol {
  func makeViewController() -> ListingsViewLoadable
}

protocol ListingsViewLoadable: UIViewController {
  func viewDidLoad()
}
