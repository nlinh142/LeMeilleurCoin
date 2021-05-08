//
//  ListingDetailsPresenter.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

protocol ListingDetailsPresenterDependencies {
  var interactor: ListingDetailsInteractorInput { get }
  var stringFormatter: StringFormatterProtocol { get }
  var dateFormatter: DateFormatterProtocol { get }
  var priceFormatter: PriceFormatterProtocol { get }
  var localizator: ListingDetailsLocalizable { get }
  var assetsProvider: ListingDetailsAssetsProviderProtocol { get }
}

final class ListingDetailsPresenter {

  // MARK: - Enum
  
  private enum Constants {
    enum Title {
      static let font: UIFont = .boldSystemFont(ofSize: 18.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .center
    }
    
    enum Category {
      static let font: UIFont = .italicSystemFont(ofSize: 14.0)
      static let textColor: UIColor = .systemOrange
      static let textAlignment: NSTextAlignment = .natural
    }
    
    enum Price {
      static let font: UIFont = .boldSystemFont(ofSize: 16.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .natural
      static let minimumFractionDigits: Int = 0
      static let maximumFractionDigits: Int = 2
      static let currencyCode: String = "EUR"
    }
    
    enum Description {
      static let font: UIFont = .systemFont(ofSize: 14.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .natural
    }
    
    enum Date {
      static let font: UIFont = .systemFont(ofSize: 13.0)
      static let textColor: UIColor = .gray
      static let textAlignment: NSTextAlignment = .natural
      static let dateStyle: DateFormatterStyle = .medium
      static let timeStyle: DateFormatterStyle = .medium
      static let currencyCode: String = "EUR"
    }
    
    enum Siret {
      static let format: String = "SIRET: %@"
      static let font: UIFont = .italicSystemFont(ofSize: 13.0)
      static let textColor: UIColor = .black
      static let textAlignment: NSTextAlignment = .natural
    }
  }

  // MARK: - Properties

  weak var output: ListingDetailsPresenterOutput?
  private let interactor: ListingDetailsInteractorInput
  private let stringFormatter: StringFormatterProtocol
  private let dateFormatter: DateFormatterProtocol
  private let priceFormatter: PriceFormatterProtocol
  private let localizator: ListingDetailsLocalizable
  private let assetsProvider: ListingDetailsAssetsProviderProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsPresenterDependencies) {
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
  
  private func formattedDescription(with description: String) -> NSAttributedString {
    stringFormatter.format(string: description,
                           font: Constants.Description.font,
                           textColor: Constants.Description.textColor,
                           textAlignment: Constants.Description.textAlignment)
  }
  
  private func formattedSiretDescription(with siret: String) -> NSAttributedString {
    stringFormatter.format(string: String(format: Constants.Siret.format, siret),
                           font: Constants.Siret.font,
                           textColor: Constants.Siret.textColor,
                           textAlignment: Constants.Siret.textAlignment)
  }
}

// MARK: - ListingDetailsPresenterInput

extension ListingDetailsPresenter: ListingDetailsPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }
  
  func didTapCloseButton() {
    interactor.quit()
  }
  
  func didTapAlertConfirmationButton() {
    interactor.handleNoDataErrorConfirmation()
  }
}

// MARK: - ListingDetailsInteractorOutput

extension ListingDetailsPresenter: ListingDetailsInteractorOutput {
  func setDefaultValues() {}

  func notifyLoading() {
    output?.showLoading()
  }

  func notifyEndLoading() {
    output?.hideLoading()
  }

  func notifyNoDataError() {
    let alertItem = AlertItem(title: localizator.fetchingErrorTitle,
                              message: localizator.fetchingErrorMessage,
                              confirmationButtonTitle: localizator.fetchingErrorConfirmationButtonTitle)
    output?.display(alert: alertItem)
  }

  func notify(categories: [ListingDetailsCategory]) {
    var viewCategories: [ListingDetailsViewCategory] = []
    
    for category in categories {
      switch category {
      case let .title(title):
        viewCategories.append(.title(formattedTitle(with: title)))
      case let .categoryName(category):
        viewCategories.append(.categoryName(formattedCategory(with: category)))
      case let .imageUrl(url):
        viewCategories.append(.image(url: url, placeholder: assetsProvider.listingPlaceholderImage))
      case let .price(price):
        viewCategories.append(.priceDescription(formattedPriceDescription(with: price)))
      case let .creationDate(date):
        viewCategories.append(.creationDateDescription(formattedDateDescription(with: date)))
      case let .description(description):
        guard let description = description else { break }
        viewCategories.append(.description(formattedDescription(with: description)))
      case let .siret(siret):
        guard let siret = siret else { break }
        viewCategories.append(.siret(formattedSiretDescription(with: siret)))
      }
    }
    
    output?.display(viewCategories: viewCategories)
  }
  
  func notify(isUrgent: Bool) {
    if isUrgent {
      output?.displayUrgentIndicator()
    }
  }
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
