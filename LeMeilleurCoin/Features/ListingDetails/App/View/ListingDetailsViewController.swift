//
//  ListingDetailsViewController.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

protocol ListingDetailsViewDependencies {
  var presenter: ListingDetailsPresenterInput! { get }
}

class ListingDetailsViewController: UIViewController, Loadable {
  
  // MARK: - Properties
  
  var dependencies: ListingDetailsViewDependencies!
  
  private lazy var scrollView: UIScrollView = .init()
  private lazy var stackView: UIStackView = .init()
  
  var activityIndicator: UIActivityIndicatorView?
  
  var viewsToHideDuringLoading: [UIView] {
    [scrollView]
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    dependencies.presenter.viewDidLoad()
  }
  
  // MARK: - Private
  
  private func setupUI() {
    view.backgroundColor = .white
    
    setupCloseButton()
    setupScrollView()
    setupStackView()
  }
  
  private func setupCloseButton() {
    let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                      target: self,
                                      action: #selector(closeButtonDidTouchUpInside(_:)))
    navigationItem.leftBarButtonItem = closeButton
  }
  
  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.alwaysBounceVertical = false
    scrollView.alwaysBounceHorizontal = false
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    view.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
  }
  
  private func setupStackView() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.axis = .vertical
    stackView.spacing = 16.0
    
    scrollView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }
  
  private func addText(_ text: NSAttributedString) {
    let label = UILabel()
    label.backgroundColor = .clear
    label.attributedText = text
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    
    let container = UIView()
    container.backgroundColor = .clear
    container.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      label.topAnchor.constraint(equalTo: container.topAnchor),
      label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
    
    stackView.addArrangedSubview(container)
  }
  
  private func addImage(with imageUrl: String?, placeholder: UIImage?) {
    let imageView = AsyncImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8.0
    imageView.contentMode = .scaleAspectFill
    imageView.placeholderImage = placeholder
    imageView.imageUrl = imageUrl
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let container = UIView()
    container.backgroundColor = .clear
    container.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: container.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
    
    stackView.addArrangedSubview(container)
  }
  
  @objc
  private func closeButtonDidTouchUpInside(_ sender: UIButton) {
    dependencies.presenter.didTapCloseButton()
  }
}

// MARK: - ListingDetailsViewLoadable

extension ListingDetailsViewController: ListingDetailsViewLoadable {}

// MARK: - ListingDetailsPresenterOutput

extension ListingDetailsViewController: ListingDetailsPresenterOutput {
  func showLoading() {
    startLoading(animated: true, activityIndicatorColor: .systemOrange, activityIndicatorViewStyle: .whiteLarge)
  }
  
  func hideLoading() {
    stopLoading()
  }
  
  func display(alert: AlertItemProtocol) {
    let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
    let action = UIAlertAction(title: alert.confirmationButtonTitle, style: .default) { _ in
      self.dependencies.presenter.didTapAlertConfirmationButton()
    }
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
  }
  
  func display(viewCategories: [ListingDetailsViewCategory]) {
    stackView.subviews.forEach { $0.removeFromSuperview() }
    
    for viewCategory in viewCategories {
      switch viewCategory {
      case let .title(text),
           let .categoryName(text),
           let .creationDateDescription(text),
           let .description(text),
           let .priceDescription(text),
           let .siret(text):
        addText(text)
      case let .image(url: imageUrl, placeholder: placeholderImage):
        addImage(with: imageUrl, placeholder: placeholderImage)
      }
    }
  }
  
  func displayUrgentIndicator() {
    UrgentIndicatorLabel.show(on: scrollView)
  }
}
