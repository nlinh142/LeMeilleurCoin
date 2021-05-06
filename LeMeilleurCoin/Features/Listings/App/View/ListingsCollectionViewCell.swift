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
    layer.masksToBounds = true
    layer.cornerRadius = 8.0
    
    contentStackView.spacing = 8.0
    contentStackView.distribution = .fill
    contentStackView.alignment = .center
    contentStackView.axis = .horizontal
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(contentStackView)
    
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8.0
    imageView.contentMode = .scaleAspectFill
    contentStackView.addArrangedSubview(imageView)
    
    textStackView.spacing = 8.0
    textStackView.distribution = .fill
    textStackView.axis = .vertical
    textStackView.addArrangedSubview(titleLabel)
    textStackView.addArrangedSubview(categoryLabel)
    textStackView.addArrangedSubview(priceLabel)
    textStackView.addArrangedSubview(creationDateLabel)
    contentStackView.addArrangedSubview(textStackView)
    
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
      contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
      contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      imageView.widthAnchor.constraint(equalToConstant: 75.0),
      imageView.heightAnchor.constraint(equalToConstant: 100.0)
    ])
  }
  
  // MARK: - Configuration
  
  func configure(with item: ListingsViewItemProtocol) {
    imageView.placeholderImage = item.placeholderImage
    imageView.imageUrl = item.imageUrl
    
    titleLabel.numberOfLines = 0
    titleLabel.attributedText = item.title
    categoryLabel.attributedText = item.category
    creationDateLabel.attributedText = item.creationDateDescription
    priceLabel.attributedText = item.priceDescription
    
    if item.shouldDisplayUrgentIndicator {
      UrgentIndicatorLabel.show(on: self)
    } else {
      UrgentIndicatorLabel.hide(on: self)
    }
  }
}
