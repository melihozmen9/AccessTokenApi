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
        
        
        return topLabel
    }()
    
    private lazy var botLabel:CustomLabel = {
       let botLabel = CustomLabel()
        
        
        return botLabel
    }()
    
    private lazy var descriptionButton:CustomButton = {
        let descriptionButton = CustomButton()
        descriptionButton.setImage(UIImage(named: "helpAndSupportButton.png"), for: .normal)
        
        return descriptionButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        contentView.addSubviews(topLabel, botLabel, descriptionButton)
        setupLayout()
    }
    
    func setupLayout() {
        
        topLabel.edgesToSuperview(excluding: .none, insets: .left(12) + .top(16) + .bottom(15) + .right(46))
        
        descriptionButton.edgesToSuperview(excluding: .left, insets: .top(32) + .bottom(30.59) + .right(18.37))
        descriptionButton.leadingToTrailing(of: topLabel, offset: 12)
    }
    
}
