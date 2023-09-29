//
//  NetworkService.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 20/09/23.
//

import Foundation

enum NetworkError: Error {
  case invalidEndpoint(String?)
  case failToParse(message: String)
  case responseError(message: String)
}

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidEndpoint(let url):
      return "The endpoint is invalid: \(url ?? "")"
    case .failToParse(let message):
      return "Fail to parse response: \(message)"
    case .responseError(let message):
      return "Response Error ---> \(message)"
    }
  }
}

protocol NetworkServiceProtocol {
  func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  
  func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, NetworkError>) -> Void) {
    
    var queryItems: [URLQueryItem] = []
    
    guard var urlComponent = URLComponents(string: request.url) else {
      return completion(.failure(.invalidEndpoint(request.url)))
    }
    
    request.queryItems.forEach {
      let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
      urlComponent.queryItems?.append(urlQueryItem)
      queryItems.append(urlQueryItem)
    }
    
    urlComponent.queryItems = queryItems
    
    guard let url = urlComponent.url else {
      return completion(.failure(.invalidEndpoint(nil)))
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if let error = error {
        return completion(.failure(.responseError(message: error.localizedDescription)))
      }
      
      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        return completion(.failure(.responseError(message: "\(String(describing: (response as? HTTPURLResponse)?.statusCode))")))
      }
      
      guard let data = data else {
        return completion(.failure(.responseError(message: "data error")))
      }
      
      do {
        try (completion(.success(request.decode(data))))
      } catch let error as NSError {
        completion(.failure(.failToParse(message: error.localizedDescription)))
      }
    }
    .resume()
  }
}
