//
//  Collection+Safe.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 02/05/2021.
//

import Foundation

extension Collection {
  subscript (safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}
