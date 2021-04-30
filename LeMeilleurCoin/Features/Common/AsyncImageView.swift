//
//  AsyncImageView.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 30/04/2021.
//

import UIKit

final class AsyncImageView: UIImageView {
  
  // MARK: - Properties
  
  private let downloader: APIServiceProtocol
  
  var placeholderImage: UIImage? {
    didSet {
      if image == nil {
        image = placeholderImage
      }
    }
  }
  
  var imageUrl: String? {
    didSet {
      if let imageUrl = imageUrl {
        load(with: imageUrl)
      }
    }
  }
  
  // MARK: - Init
  
  init(frame: CGRect, downloader: APIServiceProtocol) {
    self.downloader = downloader
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private
  
  private func load(with urlString: String) {
    downloader.fetchData(from: urlString) { [weak self] result in
      switch result {
      case let .success(data):
        self?.image = UIImage(data: data)
      case .failure:
        break
      }
    }
  }
}
