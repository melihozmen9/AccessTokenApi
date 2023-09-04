//
//  SecurityCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 4.09.2023.
//

import UIKit
import TinyConstraints
class SecurityCell: UITableViewCell {
    
    private lazy var switchView: CustomSwitchView = {
        let v = CustomSwitchView()
        return v
    }()
    
    private lazy var passwordView: CustomView = {
        let v = CustomView()
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(section: Int,data:String) {
        if section == 0 {
            passwordView.edgesToSuperview()
            passwordView.Lbl.text = data
        } else if section == 1 {
            switchView.edgesToSuperview()
            switchView.Lbl.text = data
        }
    }
    
    private func setupView() {
        contentView.addSubviews(passwordView,switchView)
        //setupLayout()
    }
    
    
    
}
