//
//  ListingDetailsModuleFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import UIKit

protocol ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable
}

protocol ListingDetailsModuleFactoryDependencies {
  var interactorFactory: ListingDetailsInteractorFactoryProtocol { get }
}

final class ListingDetailsModuleFactory: ListingDetailsViewDependencies {
  
  // MARK: - Properties

  var presenter: ListingDetailsPresenterInput!
  private var interactorFactory: ListingDetailsInteractorFactoryProtocol
  private lazy var router: ListingDetailsRouter = .init()

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsModuleFactoryDependencies) {
    interactorFactory = dependencies.interactorFactory
  }
  
  // MARK: - Private
  
  private func makeInteractorFactoryResponseModel() -> ListingDetailsInteractorFactoryResponse {
    let routerAdapter = ListingDetailsRouterAdapter(router: router)
    
    let interactorFactoryRequest = ListingDetailsInteractorFactoryRequestModel(
      currentListingFetchRepository: CurrentListingRepository.shared,
      currentListingClearRepository: CurrentListingRepository.shared,
      router: routerAdapter
    )
    
    return interactorFactory.makeResponse(with: interactorFactoryRequest)
  }
}

// MARK: - ListingDetailsModuleFactoryProtocol

extension ListingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable {
    let interactorFactoryResponse = makeInteractorFactoryResponseModel()
    
    let dependencies = ListingDetailsPresenterDependenciesModel(
      interactor: interactorFactoryResponse.interactor,
      stringFormatter: AppStringFormatter(),
      dateFormatter: AppDateFormatter(),
      priceFormatter: AppPriceFormatter(),
      localizator: ListingDetailsLocalizator(),
      assetsProvider: ListingDetailsAssetsProvider()
    )
    let presenter = ListingDetailsPresenter(dependencies: dependencies)

    interactorFactory.output = presenter
    let viewController = ListingDetailsViewController()
    viewController.dependencies = self
    presenter.output = viewController
    router.viewController = viewController
    self.presenter = presenter
    return viewController
  }
}

// MARK: - ListingDetailsInteractorFactoryRequest

private struct ListingDetailsInteractorFactoryRequestModel: ListingDetailsInteractorFactoryRequest {
  let currentListingFetchRepository: CurrentListingFetching
  let currentListingClearRepository: CurrentListingClearing
  let router: ListingDetailsRouting
}

// MARK: - ListingDetailsModuleFactoryDependencies

private struct ListingDetailsModuleFactoryDependenciesModel: ListingDetailsModuleFactoryDependencies {
  let interactorFactory: ListingDetailsInteractorFactoryProtocol
}

// MARK: - ListingDetailsPresenterDependencies

private struct ListingDetailsPresenterDependenciesModel: ListingDetailsPresenterDependencies {
  let interactor: ListingDetailsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let dateFormatter: DateFormatterProtocol
  let priceFormatter: PriceFormatterProtocol
  let localizator: ListingDetailsLocalizable
  let assetsProvider: ListingDetailsAssetsProviderProtocol
}

// MARK: - ListingDetailsLocalizable

private struct ListingDetailsLocalizator: ListingDetailsLocalizable {
  var fetchingErrorTitle: String {
    "Technical error"
  }
  
  var fetchingErrorMessage: String {
    "There is an error while retrieving listing details. Please try again later."
  }
  
  var fetchingErrorConfirmationButtonTitle: String {
    "OK"
  }
}

// MARK: - ListingDetailsAssetsProviderProtocol

private struct ListingDetailsAssetsProvider: ListingDetailsAssetsProviderProtocol {
  var listingPlaceholderImage: UIImage {
    UIImage(named: "placeholder") ?? UIImage()
  }
}
