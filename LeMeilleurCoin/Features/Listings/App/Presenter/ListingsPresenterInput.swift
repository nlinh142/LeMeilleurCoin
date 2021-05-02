//
//  ListingsPresenterInput.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsViewItemProtocol {
  var title: NSAttributedString { get }
  var category: NSAttributedString { get }
  var imageUrl: String? { get }
  var placeholderImage: UIImage { get }
  var priceDescription: NSAttributedString { get }
  var creationDateDescription: NSAttributedString { get }
  var isUrgent: Bool { get }
}

protocol ListingsPresenterInput {
  func viewDidLoad()
  func numberOfSections() -> Int
  func numberOfItems(in section: Int) -> Int
  func viewItem(at indexPath: IndexPath) -> ListingsViewItemProtocol
  func didSelectItem(at indexPath: IndexPath)
}
