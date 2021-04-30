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
protocol ListingDetailsModuleFactoryDependenciesProtocol {
  var interactorFactory: ListingDetailsInteractorFactoryProtocol { get }
}

final class ListingDetailsModuleFactory: ListingDetailsViewDependenciesProtocol {
  
  // MARK: - Properties

  var presenter: ListingDetailsPresenterInput!
  private var interactorFactory: ListingDetailsInteractorFactoryProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingDetailsModuleFactoryDependenciesProtocol) {
    interactorFactory = dependencies.interactorFactory
  }
}

// MARK: - ListingDetailsModuleFactoryProtocol

extension ListingDetailsModuleFactory: ListingDetailsModuleFactoryProtocol {
  func makeViewController() -> ListingDetailsViewLoadable {

    let request = ListingDetailsInteractorFactoryRequest()
    let response = interactorFactory.makeResponse(from: request)
    let dependencies = ListingDetailsPresenterDependencies(
      interactor: response.interactor,
      stringFormatter: StringFormatter(),
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

// MARK: - ListingDetailsInteractorFactoryRequestProtocol

private struct ListingDetailsInteractorFactoryRequest: ListingDetailsInteractorFactoryRequestProtocol {
}

// MARK: - ListingDetailsPresenterDependenciesProtocol

private struct ListingDetailsPresenterDependencies: ListingDetailsPresenterDependenciesProtocol {
  let interactor: ListingDetailsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let localizator: ListingDetailsLocalizable
}

// MARK: - ListingDetailsLocalizable

private struct ListingDetailsLocalizator: ListingDetailsLocalizable {}
