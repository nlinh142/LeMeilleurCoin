//
//  ListingDetailsModuleFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

/// sourcery: AutoMockableModuleFactories
protocol ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable
}

/// sourcery: AutoMockableModuleFactories
protocol ListingDetailsModuleFactoryDependencies {
  var interactorFactory: ListingDetailsInteractorFactoryProtocol { get }
}

final class ListingDetailsModuleFactory: ListingDetailsViewDependencies {
  
  // MARK: - Properties

  var presenter: ListingDetailsPresenterInput!
  private var interactorFactory: ListingDetailsInteractorFactoryProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsModuleFactoryDependencies) {
    interactorFactory = dependencies.interactorFactory
  }
}

// MARK: - ListingDetailsModuleFactoryProtocol

extension ListingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable {

    let request = ListingDetailsInteractorFactoryRequestModel()
    let response = interactorFactory.makeResponse(from: request)
    let dependencies = ListingDetailsPresenterDependenciesModel(
      interactor: response.interactor,
      stringFormatter: AppStringFormatter(),
      localizator: ListingDetailsLocalizator()
    )
    let presenter = ListingDetailsPresenter(dependencies: dependencies)

    interactorFactory.output = presenter
    let viewController = ListingDetailsViewController()
    viewController.dependencies = self
    presenter.output = viewController
    self.presenter = presenter
    return viewController
  }
}

// MARK: - ListingDetailsInteractorFactoryRequest

private struct ListingDetailsInteractorFactoryRequestModel: ListingDetailsInteractorFactoryRequest {
}

// MARK: - ListingDetailsPresenterDependencies

private struct ListingDetailsPresenterDependenciesModel: ListingDetailsPresenterDependencies {
  let interactor: ListingDetailsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let localizator: ListingDetailsLocalizable
}

// MARK: - ListingDetailsLocalizable

private struct ListingDetailsLocalizator: ListingDetailsLocalizable {}
