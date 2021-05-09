//
//  ListingDetailsPresenterOutput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

enum ListingDetailsViewCategory {
  case image(url: String?, placeholder: UIImage?)
  case title(NSAttributedString)
  case categoryName(NSAttributedString)
  case priceDescription(NSAttributedString)
  case description(NSAttributedString)
  case creationDateDescription(NSAttributedString)
  case siret(NSAttributedString)
  case id(NSAttributedString)
}

protocol ListingDetailsPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func set(closeButtonTitle: String)
  func display(alert: AlertItemProtocol)
  func display(viewCategories: [ListingDetailsViewCategory])
  func displayUrgentIndicator()
}
