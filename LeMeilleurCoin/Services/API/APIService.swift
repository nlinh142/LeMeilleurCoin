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
  func fetchJsonList<T: Decodable>(elementType: T.Type,
                                   from urlString: String,
                                   completion: @escaping (Result<[T], APIError>) -> Void)
  func fetchData(from urlString: String,
                 completion: @escaping (Result<Data, APIError>) -> Void)
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
  
  private func list<T: Decodable>(elementType: T.Type, from data: Data) throws -> [T] {
    try decoder.decode([T].self, from: data)
  }
}

// MARK: - APIServiceProtocol

extension AppAPIService: APIServiceProtocol {
  func fetchJsonList<T: Decodable>(elementType: T.Type,
                                   from urlString: String,
                                   completion: @escaping (Result<[T], APIError>) -> Void) {
    fetchData(from: urlString) { [weak self] result in
      guard let self = self else {
        return completion(.failure(APIError.noData))
      }
      
      switch result {
      case let .failure(error):
        completion(.failure(self.apiError(from: error)))
      case let .success(data):
        do {
          let list = try self.list(elementType: elementType, from: data)
          completion(.success(list))
        } catch {
          completion(.failure(self.apiError(from: error)))
        }
      }
    }
  }
  
  func fetchData(from urlString: String,
                 completion: @escaping (Result<Data, APIError>) -> Void) {
    guard let url = URL(string: urlString) else {
      return completion(.failure(APIError.invalidRequest))
    }
    
    var request = URLRequest(url: url)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
    request.httpMethod = "GET"
    request.timeoutInterval = 30
    
    let session = URLSession(configuration: .default)
    
    let dataTask = session.dataTask(with: request) { data, _, error in
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
