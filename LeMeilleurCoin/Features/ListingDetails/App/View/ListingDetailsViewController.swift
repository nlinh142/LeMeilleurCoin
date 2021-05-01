//
//  ListingDetailsViewController.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

/// sourcery: AutoMockableAccorHotelsApp
protocol ListingDetailsViewDependencies {
  var presenter: ListingDetailsPresenterInput! { get }
}

protocol ListingDetailsViewLoadable: UIViewController {
  func viewDidLoad()
}

class ListingDetailsViewController: UIViewController {

  // MARK: - Outlets

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
    
  }

  func hideLoading() {
    
  }
}
