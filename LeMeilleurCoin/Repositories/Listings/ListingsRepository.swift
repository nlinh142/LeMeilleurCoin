//
//  ListingsRepository.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

protocol ListingsRepositoryDependencies {
  var apiService: APIServiceProtocol { get }
  var dateFormatter: DateFormatterProtocol { get }
}

final class ListingsRepository {
  
  // MARK: - Enum
  
  private enum Constants {
    static let urlString: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
    static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let smallImageKey: String = "small"
    static let thumbImageKey: String = "thumb"
  }
  
  // MARK: - Properties
  
  private let apiService: APIServiceProtocol
  private let dateFormatter: DateFormatterProtocol
  
  // MARK: - Init
  
  init(dependencies: ListingsRepositoryDependencies) {
    apiService = dependencies.apiService
    dateFormatter = dependencies.dateFormatter
  }
  
  // MARK: - Private
  
  private func fetchingError(from error: Error) -> ListingsFetchingError {
    switch error {
    case APIError.noData:
      return .noData
    default:
      return .unknown
    }
  }
  
  private func fetchingResponses(from apiResponses: [ListingFetchingAPIResponse]) -> [ListingsFetchingResponse] {
    apiResponses.map {
      ListingsFetchingResponseModel(id: $0.id,
                                    categoryId: $0.categoryId,
                                    title: $0.title,
                                    description: $0.description,
                                    price: $0.price,
                                    imageUrls: self.imageUrlsResponse(from: $0.imageUrls),
                                    creationDate: self.date(from: $0.creationDate),
                                    isUrgent: $0.isUrgent,
                                    siret: $0.siret)
    }
  }
  
  private func imageUrlsResponse(from imageUrls: [String: String]?) -> ListingsFetchingImageUrlsResponse? {
    guard let imageUrls = imageUrls else { return nil }
    return ListingsFetchingImageUrlsResponseModel(
      small: imageUrls[Constants.smallImageKey],
      thumb: imageUrls[Constants.thumbImageKey]
    )
  }
  
  private func date(from dateString: String?) -> Date? {
    guard let dateString = dateString else { return nil }
    return dateFormatter.date(from: dateString, with: Constants.dateFormat)
  }
}

// MARK: - ListingsFetching

extension ListingsRepository: ListingsFetching {
  func fetch(completion: @escaping (Result<[ListingsFetchingResponse], ListingsFetchingError>) -> Void) {
    apiService.fetchJsonList(elementType: ListingFetchingAPIResponse.self,
                             from: Constants.urlString) { result in
      switch result {
      case let .success(responses):
        completion(.success(self.fetchingResponses(from: responses)))
      case let .failure(error):
        completion(.failure(self.fetchingError(from: error)))
      }
    }
  }
}

// MARK: - ListingsFetchingResponse

private struct ListingsFetchingResponseModel: ListingsFetchingResponse {
  let id: UInt?
  let categoryId: UInt8?
  let title: String?
  let description: String?
  let price: Float?
  let imageUrls: ListingsFetchingImageUrlsResponse?
  let creationDate: Date?
  let isUrgent: Bool?
  let siret: String?
}

// MARK: - ListingsFetchingImageUrlsResponse

private struct ListingsFetchingImageUrlsResponseModel: ListingsFetchingImageUrlsResponse {
  let small: String?
  let thumb: String?
}

// MARK: - ListingFetchingAPIResponse

private struct ListingFetchingAPIResponse: Codable {
  var id: UInt?
  var categoryId: UInt8?
  var title: String?
  var description: String?
  var price: Float?
  var imageUrls: [String: String]?
  var creationDate: String?
  var isUrgent: Bool?
  var siret: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case categoryId = "category_id"
    case title
    case description
    case price
    case imageUrls = "images_url"
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
    case siret
  }
}
