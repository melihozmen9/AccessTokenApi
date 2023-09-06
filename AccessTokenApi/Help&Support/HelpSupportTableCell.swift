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
    
    
    private lazy var topLabel:CustomLabel = {
        let topLabel = CustomLabel()
        topLabel.textColor = Color.systemblack.chooseColor
//        topLabel.font = Font.semibold14.chooseFont
        topLabel.fontType = Font.bold30
        return topLabel
    }()
    
    private lazy var botLabel:CustomLabel = {
       let botLabel = CustomLabel()
        botLabel.textColor = Color.systemblack.chooseColor
//        botLabel.font = Font.regular10.chooseFont
        botLabel.fontType = Font.regular10
        return botLabel
    }()
    
    private lazy var descriptionButton:UIButton = {
        let descriptionButton = UIButton()
        descriptionButton.setImage(UIImage(named: "helpAndSupportButton.png"), for: .normal)
//        descriptionButton.contentMode = .scaleAspectFit
        return descriptionButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addShadowRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let topSpace: CGFloat = 12.0
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: topSpace, left: 0, bottom: 0, right: 0))
        contentView.backgroundColor = .clear
        
     }
    
    private func addShadowRadius() {
        layer.shadowColor = Color.systemgray.chooseColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupView() {
        
        contentView.addSubviews(topLabel, botLabel, descriptionButton)
        setupLayout()
    }
    
    func setupLayout() {
        
        topLabel.edgesToSuperview(excluding: .none, insets: .left(12) + .top(16) + .bottom(15) + .right(46))
        
        botLabel.topToBottom(of: topLabel, offset: 12)
        botLabel.leadingToSuperview(offset:12)
        
        descriptionButton.edgesToSuperview(excluding: .left, insets: .top(32) + .bottom(30.59) + .right(18.37))
        descriptionButton.leadingToTrailing(of: topLabel, offset: 12)
    }
    
}
