//
//  ViewController.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 20/09/23.
//

import UIKit

class MainPageViewController: UIViewController {
  var heroCollectionView: UICollectionView?
  private var heroes: [HeroData] = []
  private var presenter: MainPagePresentable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeroCollectionView()
    presenter = MainPagePresenter(view: self)
    presenter?.getHeroList()
    view.backgroundColor = UIColor(hex: "#1f3057")
  }
  
  private func setupHeroCollectionView() {
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    layout.itemSize = CGSize(width: 180, height: 250)
    
    heroCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    
    heroCollectionView?.register(HeroCellView.self, forCellWithReuseIdentifier: "HeroCellView")
    heroCollectionView?.backgroundColor = UIColor(hex: "#1f3057")
    
    heroCollectionView?.dataSource = self
    heroCollectionView?.delegate = self
    
    heroCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(heroCollectionView ?? UICollectionView())
    let margin = view.safeAreaLayoutGuide
    
    heroCollectionView?.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
    heroCollectionView?.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
    heroCollectionView?.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
    heroCollectionView?.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
  }
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return heroes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCellView", for: indexPath) as? HeroCellView else {
      return UICollectionViewCell()
    }
    cell.config(with: heroes[indexPath.row])
    return cell
  }
}

extension MainPageViewController: MainPageViewable {
  func pupulateHeros(heroes: [HeroData]) {
    self.heroes = heroes
    heroCollectionView?.reloadData()
  }
  
  func displayError(message: String) {
    let alert = UIAlertController(title: "Error 😞", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
}
