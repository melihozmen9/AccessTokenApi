//
//  VisitCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
class VisitCell: UITableViewCell {
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "amsterdam")
        return iv
    }()
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "visitWhite")
        return iv
    }()
    
    private lazy var Lbl: UILabel = {
        let l = UILabel()
        l.font = Font.regular16.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Amsterdam"
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func configure(travelItem: TravelItem) {
        Lbl.text = travelItem.location
        guard let safeUrl = travelItem.image_url else {return}
        let url = URL(string: safeUrl)
        imageview.kf.setImage(with: url)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        self.imageview.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    private func setupView() {
        self.backgroundColor = Color.systemWhite.chooseColor
        self.contentView.addSubViews(imageview)
        imageview.addSubViews(Lbl,iconView)
        setupLayout()
    }
    private func setupLayout() {
        imageview.edgesToSuperview(insets: .bottom(16))
        
        iconView.edgesToSuperview(excluding: [.top,.right], insets: .bottom(8) + .left(10))
        iconView.height(20)
        iconView.width(15)
        
        Lbl.edgesToSuperview(excluding: [.top,.right], insets: .bottom(8) + .left(29))
        Lbl.height(24)
        Lbl.width(100)
    }
}
