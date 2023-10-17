//
//  HeroCellView.swift
//  MarvelDemo
//
//  Created by Daniel Serrano on 27/09/23.
//

import UIKit
import SDWebImage

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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowPath = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: 8
    ).cgPath
  }
  
  
  private func setupCell() {
    //contentView.backgroundColor = .blue
    contentView.addSubview(backView)
    backView.translatesAutoresizingMaskIntoConstraints = false
    configureBackView()
    
    backView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    
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
    backView.backgroundColor = UIColor(hex: "#782919")
    backView.layer.cornerRadius = 8
    backView.layer.masksToBounds = true
    
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = false
    
    contentView.layer.shadowRadius = 5.5
    contentView.layer.shadowOpacity = 0.2
    contentView.layer.shadowColor = UIColor.white.cgColor
    contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
  }
  
  func config(with data: HeroData) {
    let thuimnailHttps = data.thumbnail.path.replacingOccurrences(of: "http", with: "https")
    let imageUrl = "\(thuimnailHttps).jpg"
    heroName.text = data.name
    heroImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "heroPlaceHolder.png"))
  }
}



// TODO: move to extension file
extension UIImageView {
  func setRounded() {
    self.layer.cornerRadius = 75
    self.layer.masksToBounds = false
    self.clipsToBounds = true
    self.layer.borderWidth = 6
    self.layer.borderColor = UIColor(hex: "#197849").cgColor
  }
}

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if hexValue.hasPrefix("#") {
      hexValue.remove(at: hexValue.startIndex)
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexValue).scanHexInt64(&rgbValue)
    
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
