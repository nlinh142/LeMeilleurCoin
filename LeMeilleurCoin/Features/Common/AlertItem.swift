//
//  AlertItem.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 02/05/2021.
//

import Foundation

protocol AlertItemProtocol {
  var title: String { get }
  var message: String { get }
  var confirmationButton: String { get }
}

struct AlertItem: AlertItemProtocol {
  let title: String
  let message: String
  let confirmationButton: String
}
