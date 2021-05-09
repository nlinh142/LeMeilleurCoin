//
//  ListingDetailsInteractor.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 29/04/2021.
//  
//

import Foundation

protocol ListingDetailsInteractorDependencies {
  var currentListingFetchRepository: CurrentListingFetching { get }
  var currentListingClearRepository: CurrentListingClearing { get }
  var router: ListingDetailsRouting { get }
}

final class ListingDetailsInteractor {
  
  // MARK: - Properties
  
  weak var output: ListingDetailsInteractorOutput?
  private let currentListingFetchRepository: CurrentListingFetching
  private let currentListingClearRepository: CurrentListingClearing
  private let router: ListingDetailsRouting
  
  // MARK: - Lifecycle
  
  init(dependencies: ListingDetailsInteractorDependencies) {
    currentListingFetchRepository = dependencies.currentListingFetchRepository
    currentListingClearRepository = dependencies.currentListingClearRepository
    router = dependencies.router
  }
  
  // MARK: - Private
  
  private func notifyNoData() {
    DispatchQueue.main.async {
      self.output?.notifyEndLoading()
      self.output?.notifyNoDataError()
    }
  }
  
  private func notify(categories: [ListingDetailsCategory]) {
    DispatchQueue.main.async {
      self.output?.notifyEndLoading()
      self.output?.notify(categories: categories)
    }
  }
  
  private func notify(isUrgent: Bool) {
    DispatchQueue.main.async {
      self.output?.notify(isUrgent: isUrgent)
    }
  }
  
  private func category(from categoryResponse: CurrentListingFetchingCategoryResponse?) -> ListingCategory? {
    let dependencies = AppListingCategoryDependenciesItem(id: categoryResponse?.id, name: categoryResponse?.name)
    return try? AppListingCategory(dependencies: dependencies)
  }
  
  private func listing(from response: CurrentListingFetchingResponse) -> Listing? {
    let dependencies = AppListingDependenciesItem(
      id: response.id,
      title: response.title,
      categoryId: response.category?.id,
      description: response.description,
      price: response.price,
      imageUrls: listingImageUrls(from: response.imageUrls),
      creationDate: response.creationDate,
      isUrgent: response.isUrgent,
      siret: response.siret
    )
    return try? AppListing(dependencies: dependencies)
  }
  
  private func listingImageUrls(from imageUrls: CurrentListingFetchingImageUrlsResponse?) -> ListingImageUrls? {
    guard let imageUrls = imageUrls else { return nil }
    return ListingImageUrlsItem(small: imageUrls.small, thumb: imageUrls.thumb)
  }
  
  private func clearListingDetailsAndRoutesBack() {
    DispatchQueue.main.async {
      self.currentListingClearRepository.clear()
      self.router.routeBack()
    }
  }
}

// MARK: - ListingDetailsInteractorInput

extension ListingDetailsInteractor: ListingDetailsInteractorInput {
  func retrieve() {
    DispatchQueue.main.async {
      self.output?.setDefaultValues()
      self.output?.notifyLoading()
    }
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.currentListingFetchRepository.fetch { [weak self] response in
        guard let self = self else { return }
        
        guard let response = response,
              let listing = self.listing(from: response),
              let category = self.category(from: response.category) else {
          self.notifyNoData()
          return
        }
        
        let categories: [ListingDetailsCategory] = [
          .imageUrl(listing.imageUrls?.thumb ?? listing.imageUrls?.small),
          .title(listing.title),
          .categoryName(category.name),
          .price(listing.price),
          .description(listing.description),
          .creationDate(listing.creationDate),
          .siret(listing.siret),
          .id(listing.id)
        ]
        
        self.notify(categories: categories)
        self.notify(isUrgent: listing.isUrgent)
      }
    }
  }
  
  func quit() {
    clearListingDetailsAndRoutesBack()
  }
  
  func handleNoDataErrorConfirmation() {
    clearListingDetailsAndRoutesBack()
  }
}

// MARK: - AppListingDependencies

private struct AppListingDependenciesItem: AppListingDependencies {
  let id: UInt?
  let title: String?
  let categoryId: UInt8?
  let description: String?
  let price: Float?
  let imageUrls: ListingImageUrls?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?
}

// MARK: - ListingImageUrls

private struct ListingImageUrlsItem: ListingImageUrls {
  let small: String?
  let thumb: String?
}

// MARK: - AppListingCategoryDependencies

private struct AppListingCategoryDependenciesItem: AppListingCategoryDependencies {
  let id: UInt8?
  let name: String?
}
