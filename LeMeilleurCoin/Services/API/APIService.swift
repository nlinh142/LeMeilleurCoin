//
//  APIService.swift
//  LeMeilleurCoin
//
//  Created by Linh Nguyen on 28/04/2021.
//

import Foundation

enum APIError: Error {
  case invalidRequest
  case noData
  case parsingError
}

protocol APIServiceProtocol {
  func fetchJsonData<T: Decodable>(from urlString: String,
                                   completion: @escaping (Result<T, Error>) -> Void)
  func fetchData(from urlString: String,
                 completion: @escaping (Result<Data, Error>) -> Void)
}

final class AppAPIService {
  
  // MARK: - Properties
  
  private let decoder: JSONDecoder
  
  // MARK: - Init
  
  init() {
    decoder = JSONDecoder()
  }
  
  // MARK: - Private
  
  private func apiError(from error: Error) -> APIError {
    if error is DecodingError {
      return .parsingError
    }
    
    return .noData
  }
  
  private func model<T: Decodable>(type: T.Type, from data: Data) throws -> T {
    try decoder.decode(T.self, from: data)
  }
}

// MARK: - APIServiceProtocol

extension AppAPIService: APIServiceProtocol {
  func fetchJsonData<T: Decodable>(from urlString: String,
                                   completion: @escaping (Result<T, Error>) -> Void) {
    fetchData(from: urlString) { [weak self] result in
      guard let self = self else {
        return completion(.failure(APIError.noData))
      }
      
      switch result {
      case let .failure(error):
        completion(.failure(self.apiError(from: error)))
      case let .success(data):
        do {
          let model = try self.model(type: T.self, from: data)
          completion(.success(model))
        } catch {
          completion(.failure(self.apiError(from: error)))
        }
      }
    }
  }
  
  func fetchData(from urlString: String,
                 completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
      return completion(.failure(APIError.invalidRequest))
    }
    
    let session = URLSession(configuration: .default)
    
    let dataTask = session.dataTask(with: url) { [weak self] data, _, error in
      guard let self = self else {
        return completion(.failure(APIError.noData))
      }
      
      if let error = error {
        return completion(.failure(self.apiError(from: error)))
      }
      
      if let data = data {
        completion(.success(data))
      }
    }
    
    dataTask.resume()
  }
}
