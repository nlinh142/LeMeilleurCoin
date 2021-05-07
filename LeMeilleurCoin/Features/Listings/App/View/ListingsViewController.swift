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

// TODO: Filter by category

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
    view.backgroundColor = .init(white: 0.95, alpha: 1.0)
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.minimumInteritemSpacing = 16
    layout.scrollDirection = .vertical
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(ListingCollectionViewCell.self,
                            forCellWithReuseIdentifier: ListingCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.alwaysBounceVertical = false
    collectionView.alwaysBounceHorizontal = false
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
    startLoading(animated: true, activityIndicatorColor: .systemOrange, activityIndicatorViewStyle: .whiteLarge)
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
  
  func set(numberOfListingsPerRow: Int) {
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    let totalInteritemSpacing = layout.minimumInteritemSpacing * CGFloat(numberOfListingsPerRow - 1)
    let totalHorizontalContentInsets = collectionView.contentInset.left + collectionView.contentInset.right
    let availableWidth = collectionView.bounds.width - totalHorizontalContentInsets - totalInteritemSpacing
    let itemWidth = availableWidth/CGFloat(numberOfListingsPerRow)
    let itemSize = CGSize(width: itemWidth, height: 140)
    layout.itemSize = itemSize
    
    collectionView.setNeedsLayout()
    collectionView.layoutIfNeeded()
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
