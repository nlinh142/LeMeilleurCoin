//
//  Loadable.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 04/05/2021.
//

import UIKit

class ActivityIndicatorContainerView: UIView {}

protocol LoadableDependenciesProtocol {
  var view: UIView { get }
  var animated: Bool { get }
  var activityIndicatorStyles: ActivityIndicatorStylesProtocol { get }
}

protocol ActivityIndicatorStylesProtocol {
  var activityIndicatorColor: UIColor { get }
  var activityIndicatorViewStyle: UIActivityIndicatorView.Style { get }
}

public protocol Loadable: AnyObject {
  var viewsToHideDuringLoading: [UIView] { get }
  var activityIndicator: UIActivityIndicatorView? { get set }
  
  func startLoading()
  func startLoading(animated: Bool)
  func startLoading(animated: Bool,
                    activityIndicatorColor: UIColor,
                    activityIndicatorViewStyle: UIActivityIndicatorView.Style)
  func stopLoading()
}

public extension Loadable {
  
  func startLoading() {
    startLoading(animated: true)
  }
  
  func startLoading(animated: Bool) {
    startLoading(animated: animated,
                 activityIndicatorColor: .systemOrange,
                 activityIndicatorViewStyle: .whiteLarge)
  }
  
  func stopLoading() {
    guard activityIndicator?.isAnimating == true else { return }
    activityIndicator?.stopAnimating()
    activityIndicator?.superview?.removeFromSuperview()
    activityIndicator?.removeFromSuperview()
    for viewToHideDuringLoading in viewsToHideDuringLoading {
      viewToHideDuringLoading.alpha = 1
      viewToHideDuringLoading.subviews.forEach { $0.alpha = 1 }
      viewToHideDuringLoading.layer.sublayers?.forEach { $0.isHidden = false }
    }
  }
  
  private func startLoading(with dependencies: LoadableDependenciesProtocol) {
    activityIndicator?.superview?.removeFromSuperview()
    activityIndicator?.removeFromSuperview()
    let activityIndicatorContainerView = ActivityIndicatorContainerView()
    activityIndicatorContainerView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorContainerView.backgroundColor = .white
    dependencies.view.addSubview(activityIndicatorContainerView)
    NSLayoutConstraint.activate([
      activityIndicatorContainerView.leadingAnchor.constraint(equalTo: dependencies.view.leadingAnchor),
      activityIndicatorContainerView.trailingAnchor.constraint(equalTo: dependencies.view.trailingAnchor),
      activityIndicatorContainerView.topAnchor.constraint(equalTo: dependencies.view.topAnchor),
      activityIndicatorContainerView.bottomAnchor.constraint(equalTo: dependencies.view.bottomAnchor),
    ])
    for viewToHideDuringLoading in viewsToHideDuringLoading {
      viewToHideDuringLoading.alpha = 0
      viewToHideDuringLoading.subviews.forEach { $0.alpha = 0 }
      viewToHideDuringLoading.layer.sublayers?.forEach { $0.isHidden = true }
    }
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorContainerView.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainerView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainerView.centerYAnchor)
    ])
    activityIndicator.style = dependencies.activityIndicatorStyles.activityIndicatorViewStyle
    activityIndicator.color = dependencies.activityIndicatorStyles.activityIndicatorColor
    activityIndicator.startAnimating()
    dependencies.view.layoutIfNeeded()
    activityIndicatorContainerView.layoutIfNeeded()
    self.activityIndicator = activityIndicator
  }
}

public extension Loadable where Self: UIViewController {
  
  func startLoading(animated: Bool,
                    activityIndicatorColor: UIColor,
                    activityIndicatorViewStyle: UIActivityIndicatorView.Style) {
    let activityIndicatorStyle = ActivityIndicatorStyle(activityIndicatorColor: activityIndicatorColor,
                                                        activityIndicatorViewStyle: activityIndicatorViewStyle)
    let loadableDependencies = LoadableDependencies(view: view,
                                                    animated: animated,
                                                    activityIndicatorStyles: activityIndicatorStyle)
    
    startLoading(with: loadableDependencies)
  }
}

public extension Loadable where Self: UIView {
  
  func startLoading(animated: Bool,
                    activityIndicatorColor: UIColor,
                    activityIndicatorViewStyle: UIActivityIndicatorView.Style) {
    let activityIndicatorStyle = ActivityIndicatorStyle(activityIndicatorColor: activityIndicatorColor,
                                                        activityIndicatorViewStyle: activityIndicatorViewStyle)
    let loadableDependencies = LoadableDependencies(view: self,
                                                    animated: animated,
                                                    activityIndicatorStyles: activityIndicatorStyle)
    
    startLoading(with: loadableDependencies)
  }
}

// MARK: - LoadableDependenciesProtocol

private struct LoadableDependencies: LoadableDependenciesProtocol {
  let view: UIView
  let animated: Bool
  let activityIndicatorStyles: ActivityIndicatorStylesProtocol
}

// MARK: - ActivityIndicatorStylesProtocol

private struct ActivityIndicatorStyle: ActivityIndicatorStylesProtocol {
  let activityIndicatorColor: UIColor
  let activityIndicatorViewStyle: UIActivityIndicatorView.Style
}
