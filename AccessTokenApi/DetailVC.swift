//
//  DetailVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import UIKit
import TinyConstraints
class DetailVC: UIViewController {

    let viewModal = DetailVM()
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "amsterdam")
        return iv
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = Color.systemWhite.chooseColor
        sv.isScrollEnabled = true
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var cityLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold30.chooseFont
        l.text = "İstanbul"
        return l
    }()
    
    private lazy var dateLbl: UILabel = {
        let l = UILabel()
        l.font = Font.medium14.chooseFont
        l.text = "4 haziran 2011"
        return l
    }()
    
    private lazy var mapView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    private lazy var infoTextView: UILabel = {
       let tv = UILabel()
        tv.backgroundColor = Color.systemWhite.chooseColor
        tv.numberOfLines = 0
        tv.text = """
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
"""
        return tv
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
    }
    
    func initVM() {
//        viewModal.fetchData { user in
//
//
//        }
//
        
    }
    
    override func viewDidLayoutSubviews() {
        
        let height = infoTextView.frame.height + infoTextView.frame.origin.y
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.roundCorners(corners: [.topLeft, .topRight ,.bottomLeft], radius: 16)
    }
    
    func configure(travelItem: TravelItem) {
        cityLbl.text = travelItem.location
        dateLbl.text = travelItem.visit_date
        guard let safeUrl = travelItem.image_url else {return}
        let url = URL(string: safeUrl)
        imageview.kf.setImage(with: url)
        infoTextView.text = travelItem.information
    }
    
    private func setupView() {
        view.backgroundColor = Color.systemWhite.chooseColor
        view.addSubViews(imageview,scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(cityLbl,dateLbl,mapView,infoTextView)
        setupLayout()
    }
    
    private func setupLayout() {
        imageview.edgesToSuperview(excluding: [.bottom],usingSafeArea: false)
        imageview.height(249)
        
        scrollView.topToBottom(of: imageview)
        scrollView.leftToSuperview()
        scrollView.rightToSuperview()
        scrollView.bottomToSuperview()
        //scrollView.height(1000)
    
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
        
        cityLbl.edgesToSuperview(excluding: [.bottom,.right], insets: .top(24) + .left(24))
        cityLbl.height(45)
        cityLbl.width(200)
        
        dateLbl.topToBottom(of: cityLbl)
        dateLbl.left(to: cityLbl)
        dateLbl.height(21)
        dateLbl.width(200)
        
        mapView.topToBottom(of: dateLbl, offset: 24)
        mapView.edgesToSuperview(excluding: [.top,.bottom], insets: .left(16) + .right(16))
        mapView.height(227)
        
        infoTextView.topToBottom(of: mapView, offset: 24)
        infoTextView.edgesToSuperview(excluding: [.top,.bottom], insets: .left(16) + .right(16))
        infoTextView.bottomToSuperview()
        
        contentView.layoutSubviews() // bu contentView'in subviewALrının layoutlarını bir daha çalıştırıyor. tableView'ın reload'u gibi düşün.
        //ardından viewdidLayout subviews fonksiyonunda ben contentView içindeki componetnlerin özelliklerine erişebilirim.
        // ve en alttaki componentin y değerini ve ve yüksekliğini toplayıp scrolview'a ekliyoruz. yani layoutlar kurulduktan soran viewdidlaoutfonksiyonunda scrollView'a tekrar boyut veriyoruz. bu sayede boyutu büyüyor. hem onun contentView'ın.
        
        
        
        
    }


}
