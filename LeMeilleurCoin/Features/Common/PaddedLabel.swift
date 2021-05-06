//
//  PaddedLabel.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 06/05/2021.
//

import UIKit
import Foundation

class PaddedLabel: UILabel {

  var textInsets: UIEdgeInsets = .zero {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let x = bounds.origin.x - textInsets.left
    let y = bounds.origin.y - textInsets.top
    let width = bounds.size.width - (textInsets.left + textInsets.right)
    let height = bounds.size.height - (textInsets.top + textInsets.bottom)
    let newBounds = CGRect(x: x, y: y, width: width, height: height)

    let textRect = super.textRect(forBounds: newBounds, limitedToNumberOfLines: numberOfLines)
    let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                      left: -textInsets.left,
                                      bottom: -textInsets.bottom,
                                      right: -textInsets.right)
    
    return textRect.inset(by: invertedInsets)
  }

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
  }
}
