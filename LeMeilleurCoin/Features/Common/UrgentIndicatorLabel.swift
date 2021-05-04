//
//  UrgentIndicatorLabel.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import UIKit

final class UrgentIndicatorLabel: UILabel {
  
  // MARK: - Properties
  
  private static let shared = UrgentIndicatorLabel.makeUrgentLabel()
  
  // MARK: - Setup
  
  private static func makeUrgentLabel() -> UILabel {
    let label = UILabel()
    label.backgroundColor = .systemOrange
    label.font = .boldSystemFont(ofSize: 14)
    label.numberOfLines = 1
    label.text = "  URGENT  "
    label.textColor = .white
    label.layer.masksToBounds = true
    label.layer.cornerRadius = 12
    label.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    return label
  }
  
  class func add(to containerView: UIView) {
    let label = UrgentIndicatorLabel.shared
    label.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
    ])
    label.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
    containerView.setNeedsLayout()
    containerView.layoutIfNeeded()
  }
}
