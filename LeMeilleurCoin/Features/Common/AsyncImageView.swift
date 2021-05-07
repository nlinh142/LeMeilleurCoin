//
//  AsyncImageView.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 30/04/2021.
//

import UIKit

final class AsyncImageView: UIImageView, Loadable {
  
  // MARK: - Properties
  
  var viewsToHideDuringLoading: [UIView] = []
  var activityIndicator: UIActivityIndicatorView?
  
  private lazy var downloader: APIServiceProtocol = AppAPIService()
  
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
      } else {
        image = placeholderImage
      }
    }
  }
  
  // MARK: - Private
  
  private func load(with urlString: String?) {
    image = placeholderImage
    guard let urlString = urlString else { return }
    startLoading(animated: true, activityIndicatorColor: .systemOrange, activityIndicatorViewStyle: .gray)
    downloader.fetchData(from: urlString) { [weak self] result in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if let data = try? result.get(), let image = UIImage(data: data) {
          self.image = image
        }
        self.stopLoading()
      }
    }
  }
}
