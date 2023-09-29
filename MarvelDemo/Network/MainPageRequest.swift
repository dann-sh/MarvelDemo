//
//  MainPageRequest.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 20/09/23.
//

import Foundation
import CryptoKit

struct MainPageRequest: DataRequest {
  typealias Response = [HeroData]
  let ts = String(NSDate().timeIntervalSince1970)
  
  
  private let publicKey: String = "42f482af4c0bac6e3e8dfeca701f209d"
  private let privateKey: String = "d2a6a3968af20a78e9bf722f5479abc44e060f6a"
  
  var url: String {
    let baseURL: String = "https://gateway.marvel.com:443"
    let path: String = "/v1/public/characters"
    return baseURL + path
  }
  
  var queryItems: [String : String] {
    [
      "ts": ts,
      "apikey": publicKey,
      "hash": getHashKey(data: "\(ts)\(privateKey)\(publicKey)")
    ]
  }
  
  var method: HTTPMethod {
    .get
  }
  
  func decode(_ data: Data) throws -> [HeroData] {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let response = try decoder.decode(HeroDTO.self, from: data)
    return response.data.results
  }
}

extension MainPageRequest {
  func getHashKey(data: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(data.utf8))
    
    return digest.map {
      String(format: "%02hhx", $0)
    }.joined()
  }
}


// Move to separate file
class MainPageConnection {
  private let networkService: NetworkService
  
  init(networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  func getHeroList(completion: @escaping (Result<[HeroData], NetworkError>) -> Void) {
    networkService.request(MainPageRequest()) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
