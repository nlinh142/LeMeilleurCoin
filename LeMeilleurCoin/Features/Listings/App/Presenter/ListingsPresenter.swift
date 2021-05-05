//
//  ListingsPresenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsPresenterDependencies {
  var interactor: ListingsInteractorInput { get }
  var stringFormatter: StringFormatterProtocol { get }
  var dateFormatter: DateFormatterProtocol { get }
  var priceFormatter: PriceFormatterProtocol { get }
  var localizator: ListingsLocalizable { get }
  var assetsProvider: ListingsAssetsProviderProtocol { get }
}

final class ListingsPresenter {
  
  // MARK: - Enum
  
  private enum Constants {
    enum Title {
      static let font: UIFont = .boldSystemFont(ofSize: 15.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .natural
    }
    
    enum Category {
      static let font: UIFont = .italicSystemFont(ofSize: 12.0)
      static let textColor: UIColor = .systemOrange
      static let textAlignment: NSTextAlignment = .natural
    }
    
    enum Price {
      static let font: UIFont = .boldSystemFont(ofSize: 14.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .natural
      static let minimumFractionDigits: Int = 0
      static let maximumFractionDigits: Int = 2
      static let currencyCode: String = "EUR"
    }
    
    enum Date {
      static let font: UIFont = .systemFont(ofSize: 12.0)
      static let textColor: UIColor = .gray
      static let textAlignment: NSTextAlignment = .natural
      static let dateStyle: DateFormatterStyle = .medium
      static let timeStyle: DateFormatterStyle = .medium
      static let currencyCode: String = "EUR"
    }
  }

  // MARK: - Properties

  weak var output: ListingsPresenterOutput?
  private let interactor: ListingsInteractorInput
  private let stringFormatter: StringFormatterProtocol
  private let dateFormatter: DateFormatterProtocol
  private let priceFormatter: PriceFormatterProtocol
  private let localizator: ListingsLocalizable
  private let assetsProvider: ListingsAssetsProviderProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingsPresenterDependencies) {
    interactor = dependencies.interactor
    stringFormatter = dependencies.stringFormatter
    dateFormatter = dependencies.dateFormatter
    priceFormatter = dependencies.priceFormatter
    localizator = dependencies.localizator
    assetsProvider = dependencies.assetsProvider
  }
  
  // MARK: - Private
  
  private func formattedTitle(with title: String) -> NSAttributedString {
    stringFormatter.format(string: title,
                           font: Constants.Title.font,
                           textColor: Constants.Title.textColor,
                           textAlignment: Constants.Title.textAlignment)
  }
  
  private func formattedCategory(with categoryName: String) -> NSAttributedString {
    stringFormatter.format(string: categoryName,
                           font: Constants.Category.font,
                           textColor: Constants.Category.textColor,
                           textAlignment: Constants.Category.textAlignment)
  }
  
  private func formattedPriceDescription(with price: Float) -> NSAttributedString {
    stringFormatter.format(string: priceDescription(with: price),
                           font: Constants.Price.font,
                           textColor: Constants.Price.textColor,
                           textAlignment: Constants.Price.textAlignment)
  }
  
  private func priceDescription(with price: Float) -> String {
    let parameters = PriceFormatterParameters(
      price: price,
      currencyCode: Constants.Price.currencyCode,
      fractionDigitsMinMax: FractionDigitsMinMax(minimumFractionDigits: Constants.Price.minimumFractionDigits,
                                                 maximumFractionDigits: Constants.Price.maximumFractionDigits)
    )
    return priceFormatter.formattedPrice(with: parameters)
  }
  
  private func formattedDateDescription(with date: Date) -> NSAttributedString {
    stringFormatter.format(string: dateDescription(with: date),
                           font: Constants.Date.font,
                           textColor: Constants.Date.textColor,
                           textAlignment: Constants.Date.textAlignment)
  }
  
  private func dateDescription(with date: Date) -> String {
    dateFormatter.string(from: date, with: DateFormatterStyles(dateStyle: Constants.Date.dateStyle,
                                                               timeStyle: Constants.Date.timeStyle))
  }
}

// MARK: - ListingsPresenterInput

extension ListingsPresenter: ListingsPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }
  
  func numberOfSections() -> Int {
    interactor.numberOfCategories()
  }
  
  func numberOfItems(in section: Int) -> Int {
    interactor.numberOfItems(for: section)
  }
  
  func viewItem(at indexPath: IndexPath) -> ListingsViewItemProtocol {
    guard let item = interactor.item(at: indexPath.row, for: indexPath.section) else {
      return ListingsViewItem(title: NSAttributedString(string: ""),
                              category: NSAttributedString(string: ""),
                              imageUrl: nil,
                              placeholderImage: assetsProvider.listingPlaceholderImage,
                              priceDescription: NSAttributedString(string: ""),
                              creationDateDescription: NSAttributedString(string: ""),
                              shouldDisplayUrgentIndicator: false)
    }
    
    return ListingsViewItem(title: formattedTitle(with: item.title),
                            category: formattedCategory(with: item.category),
                            imageUrl: item.imageUrl,
                            placeholderImage: assetsProvider.listingPlaceholderImage,
                            priceDescription: formattedPriceDescription(with: item.price),
                            creationDateDescription: formattedDateDescription(with: item.creationDate),
                            shouldDisplayUrgentIndicator: item.isUrgent)
  }
  
  func didSelectItem(at indexPath: IndexPath) {
    interactor.selectItem(at: indexPath.row, for: indexPath.section)
  }
}

// MARK: - ListingsInteractorOutput

extension ListingsPresenter: ListingsInteractorOutput {
  func setDefaultValues() {
    output?.display(title: localizator.title)
  }

  func notifyLoading() {
    output?.showLoading()
  }

  func notifyEndLoading() {
    output?.hideLoading()
  }

  func notifyFetchingError() {
    let alertItem = AlertItem(title: localizator.fetchingErrorTitle,
                              message: localizator.fetchingErrorMessage,
                              confirmationButtonTitle: localizator.fetchingErrorConfirmationButton)
    output?.display(alert: alertItem)
  }
  
  func updateListings() {
    output?.refreshListings()
  }
}

// MARK: - ListingsViewItemProtocol

private struct ListingsViewItem: ListingsViewItemProtocol {
  let title: NSAttributedString
  let category: NSAttributedString
  let imageUrl: String?
  let placeholderImage: UIImage
  let priceDescription: NSAttributedString
  let creationDateDescription: NSAttributedString
  let shouldDisplayUrgentIndicator: Bool
}

// MARK: - PriceFormatterParametersProtocol

private struct PriceFormatterParameters: PriceFormatterParametersProtocol {
  let price: Float
  let currencyCode: String
  let fractionDigitsMinMax: FractionDigitsMinMaxProtocol
}

// MARK: - FractionDigitsMinMaxProtocol

private struct FractionDigitsMinMax: FractionDigitsMinMaxProtocol {
  let minimumFractionDigits: Int
  let maximumFractionDigits: Int
}

// MARK: - DateFormatterStylesProtocol

private struct DateFormatterStyles: DateFormatterStylesProtocol {
  let dateStyle: DateFormatterStyle
  let timeStyle: DateFormatterStyle
}
