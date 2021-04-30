//
//  ListingsModuleFactory.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsModuleFactoryProtocol {
  func makeViewController() -> ListingsViewLoadable
}

protocol ListingsModuleFactoryDependenciesProtocol {
  var interactorFactory: ListingsInteractorFactoryProtocol { get }
}

final class ListingsModuleFactory: ListingsViewDependenciesProtocol {
  
  // MARK: - Properties

  var presenter: ListingsPresenterInput!
  private var interactorFactory: ListingsInteractorFactoryProtocol

  // MARK: - Lifecycle

  init(dependencies: ListingsModuleFactoryDependenciesProtocol) {
    interactorFactory = dependencies.interactorFactory
  }
}

// MARK: - ListingsModuleFactoryProtocol

extension ListingsModuleFactory: ListingsModuleFactoryProtocol {
  func makeViewController() -> ListingsViewLoadable {
    let request = ListingsInteractorFactoryRequest()
    let response = interactorFactory.makeResponse(from: request)
    let dependencies = ListingsPresenterDependencies(
      interactor: response.interactor,
      stringFormatter: StringFormatter(),
      localizator: ListingsLocalizator()
    )
    let presenter = ListingsPresenter(dependencies: dependencies)

    interactorFactory.output = presenter
    let viewController = ListingsViewController()
    viewController.dependencies = self
    presenter.output = viewController
    self.presenter = presenter
    return viewController
  }
}

// MARK: - ListingsInteractorFactoryRequestProtocol

private struct ListingsInteractorFactoryRequest: ListingsInteractorFactoryRequestProtocol {
}

// MARK: - ListingsPresenterDependenciesProtocol

private struct ListingsPresenterDependencies: ListingsPresenterDependenciesProtocol {
  let interactor: ListingsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let localizator: ListingsLocalizable
}

// MARK: - ListingsLocalizable

private struct ListingsLocalizator: ListingsLocalizable {}
