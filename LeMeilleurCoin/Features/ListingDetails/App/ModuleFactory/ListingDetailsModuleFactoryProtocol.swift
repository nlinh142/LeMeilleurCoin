//
//  ListingDetailsModuleFactoryProtocol.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 08/05/2021.
//

import UIKit

protocol ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable
}

protocol ListingDetailsViewLoadable: UIViewController {
  func viewDidLoad()
}
