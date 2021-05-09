//
//  ListingsAssetsProviderStub.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import UIKit

@testable import LeMeilleurCoin

struct ListingsAssetsProviderStub: ListingsAssetsProviderProtocol {
  var listingPlaceholderImage: UIImage {
    UIImage()
  }
}
