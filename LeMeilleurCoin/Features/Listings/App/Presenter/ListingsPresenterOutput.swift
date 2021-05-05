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
  func display(title: String)
  func display(alert: AlertItemProtocol)
  func refreshListings()
  func set(numberOfListingsPerRow: Int)
}
