//
//  ListingsViewController.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsViewDependenciesProtocol {
  var presenter: ListingsPresenterInput! { get }
}

protocol ListingsViewLoadable: UIViewController {
  func viewDidLoad()
}

class ListingsViewController: UIViewController {

  // MARK: - Outlets

  // MARK: - Properties

  var dependencies: ListingsViewDependenciesProtocol!

  // MARK: - Private
}

// MARK: - ListingsViewLoadable

extension ListingsViewController: ListingsViewLoadable {

  override func viewDidLoad() {
    dependencies.presenter.viewDidLoad()
  }
}

// MARK: - ListingsPresenterOutput

extension ListingsViewController: ListingsPresenterOutput {
  func showLoading() {
    
  }

  func hideLoading() {
    
  }
}
