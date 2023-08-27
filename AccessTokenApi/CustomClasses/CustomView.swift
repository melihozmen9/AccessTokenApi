//
//  CustomView.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints

class CustomView: UIView {
    
    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.systemgray.chooseColor,
        .font: Font.regular12.chooseFont
    ]
    
    lazy var Lbl: UILabel = {
        let l = UILabel()
        l.layer.cornerRadius = 3
        l.font = Font.semibold14.chooseFont
        return l
    }()
    
    lazy var Tf: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 3
        tf.backgroundColor = .white
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    override func layoutSubviews() {
        self.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 16)
//        let demoPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 342, height: 74), byRoundingCorners:[.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 16.0, height: 16.0)).cgPath
//        
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.path = demoPath
//        shadowLayer.fillColor = UIColor.white.cgColor
//        
//        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
//        shadowLayer.shadowOpacity = 0.8
//        shadowLayer.shadowRadius = 1
//        
//        self.layer.insertSublayer(shadowLayer, at: 0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Color.white.chooseColor
        self.addSubViews(Lbl,Tf)
        setupLayout()
    }
    private func setupLayout() {
        
        Lbl.edgesToSuperview(excluding: [.bottom,.right], insets: .left(12) + .top(8))
        Lbl.height(21)
        Lbl.width(150)
        
        Tf.topToBottom(of: Lbl,offset: 8)
        Tf.left(to: Lbl)
        Tf.height(18)
    }
    
}
