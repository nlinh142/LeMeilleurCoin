//
//  ListingsInteractor.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//  
//

import Foundation

protocol ListingsInteractorDependencies {
  var listingsRepository: ListingsFetching { get }
  var categoryReferentialRepository: CategoryReferentialFetching { get }
  var currentListingRepository: CurrentListingSaving { get }
  var router: ListingsRouting { get }
  var dataSource: ListingsInteractorDataSourceProtocol { get }
}

final class ListingsInteractor {
  
  // MARK: - Properties
  
  weak var output: ListingsInteractorOutput?
  
  private let listingsRepository: ListingsFetching
  private let categoryReferentialRepository: CategoryReferentialFetching
  private let currentListingRepository: CurrentListingSaving
  private let router: ListingsRouting
  private var dataSource: ListingsInteractorDataSourceProtocol
  
  // MARK: - Lifecycle
  
  init(dependencies: ListingsInteractorDependencies) {
    listingsRepository = dependencies.listingsRepository
    categoryReferentialRepository = dependencies.categoryReferentialRepository
    currentListingRepository = dependencies.currentListingRepository
    router = dependencies.router
    dataSource = dependencies.dataSource
  }
  
  // MARK: - Private
  
  private func fetchListings(in dispatchGroup: DispatchGroup) {
    listingsRepository.fetch { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(responses):
        self.dataSource.listings = responses.compactMap { self.listing(from: $0) }
      case let .failure(error):
        self.dataSource.listingsError = error
      }
      
      dispatchGroup.leave()
    }
  }
  
  private func fetchCategoryReferential(in dispatchGroup: DispatchGroup) {
    categoryReferentialRepository.fetch { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(responses):
        self.dataSource.categories = responses.compactMap { self.category(from: $0) }
      case let .failure(error):
        self.dataSource.categoryReferentialError = error
      }
      
      dispatchGroup.leave()
    }
  }
  
  private func listing(from listingItem: ListingsFetchingResponse) -> Listing? {
    let dependencies = AppListingDependenciesItem(
      id: listingItem.id,
      title: listingItem.title,
      categoryId: listingItem.categoryId,
      description: listingItem.description,
      price: listingItem.price,
      imageUrls: listingImageUrls(from: listingItem.imageUrls),
      creationDate: listingItem.creationDate,
      isUrgent: listingItem.isUrgent,
      siret: listingItem.siret
    )
    return try? AppListing(dependencies: dependencies)
  }
  
  private func listingImageUrls(from imageUrls: ListingsFetchingImageUrlsResponse?) -> ListingImageUrls? {
    guard let imageUrls = imageUrls else { return nil }
    return ListingImageUrlsItem(small: imageUrls.small, thumb: imageUrls.thumb)
  }
  
  private func category(from categoryItem: CategoryReferentialFetchingResponse) -> ListingCategory? {
    let dependencies = AppListingCategoryDependenciesItem(id: categoryItem.id, name: categoryItem.name)
    return try? AppListingCategory(dependencies: dependencies)
  }
  
  private func category(havingId categoryId: UInt8) -> ListingCategory? {
    dataSource.categories.first(where: { $0.id == categoryId })
  }
  
  private func saveImageUrlsRequest(from imageUrls: ListingImageUrls?) -> CurrentListingSavingImageUrlsRequest? {
    guard let imageUrls = imageUrls else { return nil }
    return CurrentListingSavingImageUrlsRequestModel(small: imageUrls.small, thumb: imageUrls.thumb)
  }
  
  private func saveCategoryRequest(from category: ListingCategory) -> CurrentListingSavingCategoryRequest {
    CurrentListingSavingCategoryRequestModel(id: category.id, name: category.name)
  }
  
  private func handleFetchingResults() {
    guard dataSource.listingsError == nil, dataSource.categoryReferentialError == nil else {
      notifyFetchingError()
      return
    }
    
    guard !dataSource.listings.isEmpty, !dataSource.categories.isEmpty else {
      notifyNoValidListings()
      return
    }
    
    dataSource.listings = dataSource.listings.filter { listing in
      dataSource.categories.contains { $0.id == listing.categoryId }
    }
    
    guard !dataSource.listings.isEmpty else {
      notifyNoValidListings()
      return
    }
    
    dataSource.listings = dataSource.listings.sorted { lListing, rListing in
      switch (lListing.isUrgent, rListing.isUrgent) {
      case (true, true), (false, false):
        return lListing.creationDate.compare(rListing.creationDate) != .orderedAscending
      case (true, false):
        return true
      case (false, true):
        return false
      }
    }
    
    dataSource.listingsGroups = dataSource.categories.map { category in
      (category, dataSource.listings.filter { $0.categoryId == category.id })
    }
    
    updateListingsWithoutFilters()
  }
  
  private func updateListingsWithoutFilters(shouldNotifyEndLoading: Bool = true) {
    dataSource.selectedCategoryIndex = nil
    dataSource.currentListings = dataSource.listings
    updateListings(count: dataSource.listings.count, shouldNotifyEndLoading: shouldNotifyEndLoading)
  }
  
  private func updateListings(categoryName: String? = nil, count: Int?, shouldNotifyEndLoading: Bool) {
    DispatchQueue.main.async {
      self.output?.updateListings(categoryName: categoryName, count: count)
      if shouldNotifyEndLoading {
        self.output?.notifyEndLoading()
      }
    }
  }
  
  private func notifyFetchingError() {
    DispatchQueue.main.async {
      self.output?.notifyEndLoading()
      self.output?.notifyFetchingError()
    }
  }
  
  private func notifyNoValidListings() {
    DispatchQueue.main.async {
      self.output?.notifyEndLoading()
      self.output?.notifyNoValidListings()
    }
  }
}

// MARK: - ListingsInteractorInput

extension ListingsInteractor: ListingsInteractorInput {
  func retrieve() {
    DispatchQueue.main.async {
      self.output?.notifyLoading()
      self.output?.setDefaultValues()
    }
    
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    dispatchGroup.enter()
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.fetchListings(in: dispatchGroup)
      self.fetchCategoryReferential(in: dispatchGroup)
    }
    
    dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
      self.handleFetchingResults()
    }
  }
  
  func numberOfCategories() -> Int {
    1
  }
  
  func numberOfItems(for categoryIndex: Int) -> Int {
    return dataSource.currentListings.count
  }
  
  func item(at index: Int, for categoryIndex: Int) -> ListingItemProtocol? {
    guard let item = dataSource.currentListings[safe: index],
          let category = self.category(havingId: item.categoryId) else { return nil }
    
    return ListingItem(category: category.name,
                       title: item.title,
                       price: item.price,
                       imageUrl: item.imageUrls?.small ?? item.imageUrls?.thumb,
                       creationDate: item.creationDate,
                       isUrgent: item.isUrgent)
  }
  
  func selectItem(at index: Int, for categoryIndex: Int) {
    guard let selectedItem = dataSource.currentListings[safe: index],
          let category = self.category(havingId: selectedItem.categoryId) else { return }
    
    let saveRequest = CurrentListingSavingRequestModel(
      id: selectedItem.id,
      category: saveCategoryRequest(from: category),
      title: selectedItem.title,
      description: selectedItem.description,
      price: selectedItem.price,
      imageUrls: saveImageUrlsRequest(from: selectedItem.imageUrls),
      creationDate: selectedItem.creationDate,
      isUrgent: selectedItem.isUrgent,
      siret: selectedItem.siret)
    
    DispatchQueue.main.async {
      self.currentListingRepository.save(with: saveRequest)
      self.router.routeToListingDetails()
    }
  }
  
  func selectReset() {
    guard dataSource.selectedCategoryIndex != nil else { return }
    updateListingsWithoutFilters(shouldNotifyEndLoading: false)
  }
  
  func selectFilters() {
    output?.launchFilterSelector()
  }
  
  func numberOfFilters() -> Int {
    dataSource.categories.count
  }
  
  func filterName(at index: Int) -> String? {
    dataSource.categories[safe: index]?.name
  }
  
  func numberOfListings(filteredByCategoryAt index: Int) -> Int? {
    dataSource.listingsGroups[safe: index]?.listings.count
  }
  
  func filter(byCategoryAt index: Int) {
    guard dataSource.selectedCategoryIndex != index else { return }
    dataSource.selectedCategoryIndex = index
    let group = dataSource.listingsGroups[safe: index]
    dataSource.currentListings = group?.listings ?? []
    updateListings(categoryName: group?.category.name,
                   count: dataSource.currentListings.count,
                   shouldNotifyEndLoading: false)
  }
}

// MARK: - ListingItemProtocol

private struct ListingItem: ListingItemProtocol {
  let category: String
  let title: String
  let price: Float
  let imageUrl: String?
  let creationDate: Date
  let isUrgent: Bool
}

// MARK: - CurrentListingSavingRequest

private struct CurrentListingSavingRequestModel: CurrentListingSavingRequest {
  let id: UInt
  let category: CurrentListingSavingCategoryRequest
  let title: String
  let description: String?
  let price: Float
  let imageUrls: CurrentListingSavingImageUrlsRequest?
  let creationDate: Date
  let isUrgent: Bool
  let siret: String?
}

// MARK: - CurrentListingSavingImageUrlsRequest

private struct CurrentListingSavingImageUrlsRequestModel: CurrentListingSavingImageUrlsRequest {
  let small: String?
  let thumb: String?
}

// MARK: - CurrentListingSavingCategoryRequest

private struct CurrentListingSavingCategoryRequestModel: CurrentListingSavingCategoryRequest {
  let id: UInt8
  let name: String
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
