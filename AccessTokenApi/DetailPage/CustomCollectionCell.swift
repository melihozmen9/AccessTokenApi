//
//  CustomCollectionCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 22.08.2023.
//

import UIKit
import TinyConstraints
class CustomCollectionCell: UICollectionViewCell {
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()

    private lazy var subImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "gradient")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageItem: ImageItem) {
        let url = URL(string: imageItem.image_url)
        imageview.kf.setImage(with: url)
    }
    
    private func setupView() {
        self.contentView.addSubViews(imageview)
        
        imageview.addSubViews(subImageview)
        setupLayout()
    }
    private func setupLayout() {
        imageview.edgesToSuperview(insets: .top(0), usingSafeArea: false)
        
        subImageview.edgesToSuperview(excluding: [.top], insets: .bottom(-60))
        subImageview.height(210)
    }
    
}
