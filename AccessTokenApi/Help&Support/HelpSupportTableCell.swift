//
//  HelpSupportTableCell.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 5.09.2023.
//

import Foundation
import UIKit
import TinyConstraints

class HelpSupportTableCell:UITableViewCell {
    
    private lazy var shadowView:UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0) // Gölge yönü ve boyutu
        shadowView.layer.shadowOpacity = 0.2 // Gölge opaklığı
        shadowView.layer.shadowRadius = 4 // Gölge yarıçapı
        shadowView.layer.cornerRadius = 12 // Hücrenin köşe yuvarlama miktarı
        shadowView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return shadowView
    }()
  
    private lazy var topLabel:UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = Color.systemblack.chooseColor
        topLabel.font = Font.semibold14.chooseFont
        topLabel.numberOfLines = 0
        
        return topLabel
    }()
    
    private lazy var botLabel:UILabel = {
       let botLabel = UILabel()
        botLabel.numberOfLines = 0
        
        return botLabel
    }()
    
    private lazy var buttonImageView:UIImageView = {
       let buttonImageView = UIImageView()
        let buttonImage = UIImage(named: "helpAndSupportImage.png")
        buttonImageView.image = buttonImage
        
        return buttonImageView
    }()
    
//     lazy var stackView:UIStackView = {
//       let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 8
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        return stackView
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUp(title:String, buttonImage:UIImage) {
        topLabel.text = title
        
        buttonImageView.image = buttonImage
    }
    
    func configureDown(description:String) {
        botLabel.text = description
        
    }
    
    
    func setupView() {
        contentView.addSubview(shadowView)
        shadowView.addSubviews(topLabel, buttonImageView)
        setupLayout()
        
    }
    
    func setupLayout() {
        
        shadowView.topToSuperview(offset:3)
        shadowView.leadingToSuperview(offset:3)
        shadowView.trailingToSuperview(offset:-3)
        shadowView.bottomToSuperview(offset:-3)
        
        topLabel.edgesToSuperview(excluding: .bottom, insets: .left(12) + .right(46) + .top(16))
//        topLabel.centerYToSuperview()
        
        buttonImageView.leadingToTrailing(of: topLabel, offset: 12)
        buttonImageView.edgesToSuperview(excluding: .left, insets: .top(25) + .bottom(25) + .right(18))
        buttonImageView.height(15)
        buttonImageView.width(10)
        
        
//        stackView.top(to: contentView, offset: 8)
//        stackView.leading(to: contentView, offset: 16)
//        stackView.trailing(to: contentView, offset: -16)
//        stackView.bottom(to: contentView, offset: -8)
    }
    
//    override func layoutSubviews() {
////        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
    
//    override func layoutSubviews() {
//          super.layoutSubviews()
//          let botSpace: CGFloat = 25
//          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: botSpace, right: 0))
//        contentView.backgroundColor = .clear
//
//     }
    
    
//    private func addShadowRadius() {
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowOpacity = 0.25
//        layer.shadowRadius = 4
//        clipsToBounds = false
//        layer.cornerRadius = 16
//        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }

    
//    func setupView() {
//
//        contentView.addSubviews(topLabel, botLabel, descriptionButton)
//        setupLayout()
//    }
//
//    func setupLayout() {
//
//        topLabel.edgesToSuperview(excluding: .none, insets: .left(12) + .top(16) + .bottom(15) + .right(46))
//
////        botLabel.topToBottom(of: topLabel, offset: 12)
////        botLabel.leadingToSuperview(offset:12)
//
//        descriptionButton.edgesToSuperview(excluding: .left, insets: .top(32) + .bottom(30.59) + .right(18.37))
//        descriptionButton.leadingToTrailing(of: topLabel, offset: 12)
////        descriptionButton.bottomToTop(of: spaceView)
//
////        spaceView.edgesToSuperview(excluding: [.left, .right, .top], insets: .bottom(8))
//    }
    

    
}

//extension UICollectionViewCell {
//    
//    func radiusWithShadow(corners:UIRectCorner) {
//        
//        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
//        rectanglePath.close()
//        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = CGSize(width: 0, height: 0)

