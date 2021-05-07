//
//  ListingsModuleFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import UIKit

protocol ListingsModuleFactoryProtocol {
  func makeViewController() -> ListingsViewLoadable
}

protocol ListingsModuleFactoryDependencies {
  var interactorFactory: ListingsInteractorFactoryProtocol { get }
}

final class ListingsModuleFactory: ListingsViewDependencies {
  
  // MARK: - Properties

  var presenter: ListingsPresenterInput!
  private var interactorFactory: ListingsInteractorFactoryProtocol
  
  private lazy var dateFormatter = AppDateFormatter()
  private lazy var router: ListingsRouter = {
    let listingDetailsModuleFactoryDependencies = ListingDetailsModuleFactoryDependenciesModel(
      interactorFactory: ListingDetailsInteractorFactory()
    )
    let listingDetailsModuleFactory = ListingDetailsModuleFactory(dependencies: listingDetailsModuleFactoryDependencies)
    let listingsRouterDependencies = ListingsRouterDependenciesModel(listingDetailsModuleFactory: listingDetailsModuleFactory)
    return ListingsRouter(dependencies: listingsRouterDependencies)
  }()

  // MARK: - Lifecycle

  init(dependencies: ListingsModuleFactoryDependencies) {
    interactorFactory = dependencies.interactorFactory
  }
  
  // MARK: - Private
  
  private func makeInteractorFactoryResponseModel() -> ListingsInteractorFactoryResponse {
    let apiService = AppAPIService()
    
    let listingsRepositoryDependencies = ListingsRepositoryDependenciesModel(
      apiService: apiService,
      dateFormatter: dateFormatter
    )
    let listingsRepository = ListingsRepository(dependencies: listingsRepositoryDependencies)
    
    let categoryReferentialRepositoryDependencies = CategoryReferentialRepositoryDependenciesModel(
      apiService: apiService
    )
    let categoryReferentialRepository = CategoryReferentialRepository(dependencies: categoryReferentialRepositoryDependencies)
    
    let currentListingRepository = CurrentListingRepository.shared
    
    let routerAdapter = ListingsRouterAdapter(router: router)
    
    let interactorFactoryRequest = ListingsInteractorFactoryRequestModel(
      listingsRepository: listingsRepository,
      categoryReferentialRepository: categoryReferentialRepository,
      currentListingRepository: currentListingRepository,
      router: routerAdapter
    )
    
    return interactorFactory.makeResponse(with: interactorFactoryRequest)
  }
}

// MARK: - ListingsModuleFactoryProtocol

extension ListingsModuleFactory: ListingsModuleFactoryProtocol {
  func makeViewController() -> ListingsViewLoadable {
    let traitCollectionWrapper = TraitCollectionWrapper()
    let appTraitCollectionCenter = AppTraitCollectionCenter(wrapper: traitCollectionWrapper)
    traitCollectionWrapper.output = appTraitCollectionCenter
    
    let interactorFactoryResponse = makeInteractorFactoryResponseModel()
    
    let dependencies = ListingsPresenterDependenciesModel(
      interactor: interactorFactoryResponse.interactor,
      stringFormatter: AppStringFormatter(),
      dateFormatter: dateFormatter,
      priceFormatter: AppPriceFormatter(),
      localizator: ListingsLocalizator(),
      assetsProvider: ListingsAssetsProvider(),
      traitCollectionCenterHorizontalSizeClass: appTraitCollectionCenter
    )
    let presenter = ListingsPresenter(dependencies: dependencies)

    interactorFactory.output = presenter
    let viewController = ListingsViewController()
    viewController.dependencies = self
    presenter.output = viewController
    router.viewController = viewController
    self.presenter = presenter
    return viewController
  }
}

// MARK: - ListingsRepositoryDependencies

private struct ListingsRepositoryDependenciesModel: ListingsRepositoryDependencies {
  let apiService: APIServiceProtocol
  let dateFormatter: DateFormatterProtocol
}

// MARK: - CategoryReferentialRepositoryDependencies

private struct CategoryReferentialRepositoryDependenciesModel: CategoryReferentialRepositoryDependencies {
  let apiService: APIServiceProtocol
}

// MARK: - ListingsInteractorFactoryRequest

private struct ListingsInteractorFactoryRequestModel: ListingsInteractorFactoryRequest {
  let listingsRepository: ListingsFetching
  let categoryReferentialRepository: CategoryReferentialFetching
  let currentListingRepository: CurrentListingSaving
  let router: ListingsRouting
}

// MARK: - ListingDetailsModuleFactoryDependencies

private struct ListingDetailsModuleFactoryDependenciesModel: ListingDetailsModuleFactoryDependencies {
  let interactorFactory: ListingDetailsInteractorFactoryProtocol
}

// MARK: - ListingsRouterDependencies

private struct ListingsRouterDependenciesModel: ListingsRouterDependencies {
  let listingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol
}

// MARK: - ListingsPresenterDependencies

private struct ListingsPresenterDependenciesModel: ListingsPresenterDependencies {
  let interactor: ListingsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let dateFormatter: DateFormatterProtocol
  let priceFormatter: PriceFormatterProtocol
  let localizator: ListingsLocalizable
  let assetsProvider: ListingsAssetsProviderProtocol
  let traitCollectionCenterHorizontalSizeClass: AppTraitCollectionCenterHorizontalSizeClassGettable
}

// MARK: - ListingsLocalizable

private struct ListingsLocalizator: ListingsLocalizable {
  var title: String {
    "Listings"
  }
  
  var fetchingErrorTitle: String {
    "Technical issue"
  }
  
  var fetchingErrorMessage: String {
    "There is an error while retrieving listings. Please try again later."
  }
  
  var fetchingErrorConfirmationButton: String {
    "OK"
  }
  
  var noValidListingsTitle: String {
    "No data"
  }
  
  var noValidListingsMessage: String {
    "No valid listings have been retrieved. Please try again later."
  }
  
  var noValidListingsConfirmationButton: String {
    "OK"
  }
}

// MARK: - ListingsAssetsProviderProtocol

private struct ListingsAssetsProvider: ListingsAssetsProviderProtocol {
  var listingPlaceholderImage: UIImage {
    UIImage(named: "placeholder_small") ?? UIImage()
  }
}
