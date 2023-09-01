//
//  TableViewCell.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 29.08.2023.
//

import Foundation
import UIKit
import TinyConstraints

class CustomCvCell:UICollectionViewCell {
    
    private lazy var imageView1:UIImageView = {
       let imageView = UIImageView()
        
        
        return imageView
    }()
    
    private lazy var label:UILabel = {
      let label = UILabel()
        label.font = Font.regular14.chooseFont
        label.textColor = Color.systemblack.chooseColor
        
        return label
    }()
    
    private lazy var imageView2:UIImageView = {
       let imageView2 = UIImageView()
        imageView2.contentMode = .scaleAspectFit
        return imageView2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            setupView()
            
        }
    
//    override func layoutSubviews() {
//        self.contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
//        contentView.layer.shadowRadius = 4
//        contentView.layer.shadowOpacity = 0.2
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
//
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imgView1:UIImage, lbl:String, imgView2:UIImage) {
        
        imageView1.image = imgView1
        label.text = lbl
        imageView2.image = imgView2
    }
    
    
    func setupView() {
        
        contentView.addSubview(imageView1)
        contentView.addSubview(label)
        contentView.addSubview(imageView2)
        setupLayout()
    }
    
    func setupLayout() {
        
        
        imageView1.leadingToSuperview(offset:16)
   //     imageView1.topToSuperview(offset:18)
  //      imageView1.bottomToSuperview(offset:18.5)
        imageView1.height(17.5)
        imageView1.width(20)
        imageView1.centerYToSuperview()
        
        label.leadingToTrailing(of: imageView1, offset: 9.4)
        label.centerY(to: imageView1)
        
      //  imageView2.trailingToSuperview(offset:-16)
        imageView2.height(17.5)
        imageView2.width(20)
        imageView2.centerY(to: label)
        imageView2.leading(to: imageView1, offset: 306)
    }
    
}
