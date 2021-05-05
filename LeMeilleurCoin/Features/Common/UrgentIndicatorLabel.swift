//
//  UrgentIndicatorLabel.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import UIKit

final class UrgentIndicatorLabel: UILabel {
  
  // MARK: - Setup
  
  private static func makeUrgentLabel() -> UrgentIndicatorLabel {
    let label = UrgentIndicatorLabel()
    label.backgroundColor = .systemOrange
    label.font = .boldSystemFont(ofSize: 10)
    label.numberOfLines = 1
    label.text = "URGENT"
    label.textColor = .white
    label.heightAnchor.constraint(equalToConstant: 14).isActive = true
    
    return label
  }
  
  // MARK: - Show/hide
  
  class func show(on containerView: UIView) {
    guard !containerView.subviews.contains(where: { $0 is UrgentIndicatorLabel }) else {
      return
    }
    
    let label = UrgentIndicatorLabel.makeUrgentLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      label.topAnchor.constraint(equalTo: containerView.topAnchor)
    ])
    label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    containerView.setNeedsLayout()
    containerView.layoutIfNeeded()
  }
  
  class func hide(on containerView: UIView) {
    containerView.subviews.first { $0 is UrgentIndicatorLabel }?.removeFromSuperview()
  }
}
