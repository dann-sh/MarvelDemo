//
//  HeroCellView.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 27/09/23.
//

import UIKit

class HeroCellView: UICollectionViewCell {
  var backView = UIView()
  var heroImage = UIImageView()
  var heroName = UILabel()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupCell()
  }
  
  private func setupCell() {
    //contentView.backgroundColor = .blue
    contentView.addSubview(backView)
    configureBackView()
    
    backView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    
    backView.addSubview(heroImage)
    heroImage.translatesAutoresizingMaskIntoConstraints = false
    heroImage.backgroundColor = .yellow
  
    heroImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5).isActive = true
    heroImage.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
    heroImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    heroImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
    heroImage.setRounded()
    
    backView.addSubview(heroName)
    heroName.translatesAutoresizingMaskIntoConstraints = false
    heroName.textColor = .black
    heroName.textAlignment = .center
    heroName.numberOfLines = 2
    heroName.font = UIFont(name:"Avenir Medium", size: 16.0)
    
    heroName.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 10).isActive = true
    heroName.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
    heroName.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
    heroName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15).isActive = true
    heroName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
  }
  
  private func configureBackView() {
    backView.backgroundColor = .brown
    backView.translatesAutoresizingMaskIntoConstraints = false
    backView.layer.shadowColor = UIColor.black.cgColor
    backView.layer.shadowOpacity = 1
    backView.layer.shadowOffset = .zero
    backView.layer.shadowRadius = 20
    backView.layer.shadowPath = UIBezierPath(rect: backView.bounds).cgPath
  }
  
  func config(with data: HeroData) {
    heroName.text = data.name
  }
}



// TODO: move to extension file
extension UIImageView {
  func setRounded() {
    self.layer.cornerRadius = 75
    self.layer.masksToBounds = false
    self.clipsToBounds = true
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.cgColor
  }
}
