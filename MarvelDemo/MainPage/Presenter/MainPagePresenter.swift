//
//  MainPagePresenter.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 27/09/23.
//

import Foundation

protocol MainPagePresentable {
  func getHeroList()
}

protocol MainPageViewable: AnyObject {
  func pupulateHeros(heroes: [HeroData])
  func displayError(message: String)
}

class MainPagePresenter {
  private let networkService: NetworkService
  private weak var view: MainPageViewable?
  
  init(view: MainPageViewable, networkService: NetworkService = NetworkService()) {
    self.view = view
    self.networkService = networkService
  }
}

extension MainPagePresenter: MainPagePresentable {
  func getHeroList() {
    networkService.request(MainPageRequest()) { [weak self] result in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          self.view?.pupulateHeros(heroes: data)
        case .failure(let error):
          self.view?.displayError(message: error.localizedDescription)
        }
      }
    }
  }
}
