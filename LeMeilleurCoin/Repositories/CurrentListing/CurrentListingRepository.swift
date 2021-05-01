//
//  CurrentListingRepository.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

final class CurrentListingRepository {
  
  // MARK: - Properties
  
  static let shared: CurrentListingRepository = .init()
  
  private var response: CurrentListingFetchingResponse?
  
  // MARK: - Init
  
  private init() {}
  
  // MARK: - Private
  
  private func responseImageUrls(from imageUrls: CurrentListingSavingImageUrlsRequest?) -> CurrentListingFetchingImageUrlsResponse? {
    guard let imageUrls = imageUrls else { return nil }
    return CurrentListingFetchingImageUrlsResponseModel(small: imageUrls.small,
                                                        thumb: imageUrls.thumb)
  }
}

// MARK: - CurrentListingFetching

extension CurrentListingRepository: CurrentListingFetching {
  func fetch(completion: @escaping (CurrentListingFetchingResponse?) -> Void) {
    completion(response)
  }
}

// MARK: - CurrentListingSaving

extension CurrentListingRepository: CurrentListingSaving {
  func save(with request: CurrentListingSavingRequest) {
    response = CurrentListingFetchingResponseModel(
      id: request.id,
      categoryId: request.categoryId,
      title: request.title,
      description: request.description,
      price: request.price,
      imageUrls: responseImageUrls(from: request.imageUrls),
      creationDate: request.creationDate,
      isUrgent: request.isUrgent
    )
  }
}

// MARK: - CurrentListingClearing

extension CurrentListingRepository: CurrentListingClearing {
  func clear() {
    response = nil
  }
}

// MARK: - CurrentListingFetchingResponse

private struct CurrentListingFetchingResponseModel: CurrentListingFetchingResponse {
  let id: UInt?
  let categoryId: UInt8?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: CurrentListingFetchingImageUrlsResponse?
  let creationDate: Date?
  let isUrgent: Bool?
}

// MARK: - CurrentListingFetchingImageUrlsResponse

private struct CurrentListingFetchingImageUrlsResponseModel: CurrentListingFetchingImageUrlsResponse {
  let small: String?
  let thumb: String?
}
