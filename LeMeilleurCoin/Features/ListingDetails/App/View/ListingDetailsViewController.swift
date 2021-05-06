//
//  ListingDetailsViewController.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

protocol ListingDetailsViewDependencies {
  var presenter: ListingDetailsPresenterInput! { get }
}

protocol ListingDetailsViewLoadable: UIViewController {
  func viewDidLoad()
}

class ListingDetailsViewController: UIViewController {

  // MARK: - Properties

  var dependencies: ListingDetailsViewDependencies!

  // MARK: - Private
}

// MARK: - ListingDetailsViewLoadable

extension ListingDetailsViewController: ListingDetailsViewLoadable {

  override func viewDidLoad() {
    dependencies.presenter.viewDidLoad()
  }
}

// MARK: - ListingDetailsPresenterOutput

extension ListingDetailsViewController: ListingDetailsPresenterOutput {
  func showLoading() {
    // TODO
  }

  func hideLoading() {
    // TODO
  }
  
  func display(title: String) {
    // TODO
  }
  
  func display(alert: AlertItemProtocol) {
    // TODO
  }
  
  func display(viewCategories: [ListingDetailsViewCategory]) {
    // TODO
  }
}
