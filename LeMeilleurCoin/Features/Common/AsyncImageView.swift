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
      }
    }
  }
  
  // MARK: - Private
  
  private func load(with urlString: String?) {
    guard let urlString = urlString else { return }
    startLoading(animated: true,
                 activityIndicatorColor: .systemOrange,
                 activityIndicatorViewStyle: .gray)
    downloader.fetchData(from: urlString) { [weak self] result in
      guard let self = self else { return }
      self.stopLoading()
      if let data = try? result.get() {
        DispatchQueue.main.async {
          self.image = UIImage(data: data)
        }
      }
    }
  }
}
