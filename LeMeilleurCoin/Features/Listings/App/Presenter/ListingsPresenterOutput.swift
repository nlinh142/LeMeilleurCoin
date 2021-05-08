//
//  ListingsPresenterOutput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

protocol ListingsPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func set(title: String)
  func set(filtersButtonTitle: String)
  func set(resetButtonTitle: String)
  func display(alert: AlertItemProtocol)
  func refreshListings()
  func set(numberOfListingsPerRow: Int)
  func displayFilterSelector(title: String, cancelTitle: String)
}
