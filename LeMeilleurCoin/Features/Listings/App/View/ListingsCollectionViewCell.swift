//
//  ListingsCollectionViewCell.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import UIKit

final class ListingCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  static let identifier: String = "ListingConnectionViewCell"
  
  private var imageView: AsyncImageView = .init()
  private var titleLabel: UILabel = .init()
  private var categoryLabel: UILabel = .init()
  private var creationDateLabel: UILabel = .init()
  private var priceLabel: UILabel = .init()
  private var textStackView: UIStackView = .init()
  private var contentStackView: UIStackView = .init()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  // MARK: - Setup
  
  private func setupUI() {
    backgroundColor = .white
    
    contentStackView.spacing = 8.0
    contentStackView.distribution = .fill
    contentStackView.alignment = .center
    contentStackView.axis = .horizontal
    addSubview(contentStackView)
    
    imageView.contentMode = .scaleAspectFit
    contentStackView.addArrangedSubview(imageView)
    
    textStackView.spacing = 8.0
    textStackView.distribution = .fill
    textStackView.axis = .vertical
    contentStackView.addArrangedSubview(textStackView)
    
    textStackView.addArrangedSubview(titleLabel)
    textStackView.addArrangedSubview(categoryLabel)
    textStackView.addArrangedSubview(creationDateLabel)
    textStackView.addArrangedSubview(priceLabel)
    
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      imageView.widthAnchor.constraint(equalToConstant: 75.0),
      imageView.heightAnchor.constraint(equalToConstant: 100.0)
    ])
    
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  // MARK: - Configuration
  
  func configure(with item: ListingsViewItemProtocol) {
    imageView.placeholderImage = item.placeholderImage
    imageView.imageUrl = item.imageUrl
    
    titleLabel.numberOfLines = 0
    titleLabel.attributedText = item.title
    titleLabel.sizeToFit()
    
    categoryLabel.attributedText = item.category
    categoryLabel.sizeToFit()
    
    creationDateLabel.attributedText = item.creationDateDescription
    creationDateLabel.sizeToFit()
    
    priceLabel.attributedText = item.priceDescription
    priceLabel.sizeToFit()
    
    if item.shouldDisplayUrgentIndicator {
      UrgentIndicatorLabel.show(on: self)
    } else {
      UrgentIndicatorLabel.hide(on: self)
    }
    
    setNeedsLayout()
    layoutIfNeeded()
  }
}
