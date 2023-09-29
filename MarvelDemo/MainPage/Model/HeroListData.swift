//
//  HeroListData.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 20/09/23.
//

import Foundation

// MARK: - DTO Object
struct HeroDTO: Codable {
  let code: Int
  let data: HeroDataDTO
}

struct HeroDataDTO: Codable {
  var results: [HeroData]
}

// MARK: - Response objects
struct HeroData: Codable {
  var id: Int
  var name: String
  var description: String
  var thumbnail: HeroThumbnail
}

struct HeroThumbnail: Codable {
  var path: String
}
