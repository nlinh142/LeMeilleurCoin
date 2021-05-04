//
//  ListingsViewController.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsViewDependencies {
  var presenter: ListingsPresenterInput! { get }
}

protocol ListingsViewLoadable: UIViewController {
  func viewDidLoad()
}

class ListingsViewController: UIViewController, Loadable {
  
  // MARK: - Properties

  var dependencies: ListingsViewDependencies!
  
  var viewsToHideDuringLoading: [UIView] {
    [collectionView]
  }
  
  var activityIndicator: UIActivityIndicatorView?
  
  private var collectionView: UICollectionView!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    dependencies.presenter.viewDidLoad()
  }

  // MARK: - Private
  
  private func setupUI() {
    view.backgroundColor = .lightGray
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 16
    layout.scrollDirection = .vertical
    layout.itemSize = UICollectionViewFlowLayout.automaticSize
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.register(ListingCollectionViewCell.self,
                            forCellWithReuseIdentifier: ListingCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = true
    collectionView.alwaysBounceVertical = true
    collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - ListingsViewLoadable

extension ListingsViewController: ListingsViewLoadable {}

// MARK: - ListingsPresenterOutput

extension ListingsViewController: ListingsPresenterOutput {
  func showLoading() {
    startLoading()
  }
  
  func hideLoading() {
    stopLoading()
  }
  
  func display(title: String) {
    self.title = title
  }
  
  func display(alert: AlertItemProtocol) {
    let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
    alertController.addAction(.init(title: alert.confirmationButtonTitle, style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
  func refreshListings() {
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource

extension ListingsViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    dependencies.presenter.numberOfSections()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dependencies.presenter.numberOfItems(in: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCollectionViewCell.identifier,
                                                        for: indexPath) as? ListingCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let cellItem = dependencies.presenter.viewItem(at: indexPath)
    cell.configure(with: cellItem)
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension ListingsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    dependencies.presenter.didSelectItem(at: indexPath)
  }
}
