//
//  DetailVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import UIKit
import TinyConstraints
import MapKit
class DetailVC: UIViewController {
    
    
    var id: String?
    
    var viewModal: DetailVM?
    
    lazy var activity: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        av.center = self.view.center
        av.backgroundColor = .white
        return av
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "collectionImage")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        return cv
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3
        btn.setImage(UIImage(named: "backButton"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        return pc
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
        return l
    }()
    
    private lazy var dateLbl: UILabel = {
        let l = UILabel()
        l.font = Font.medium14.chooseFont
        return l
    }()
    
    private lazy var creatorLbl: UILabel = {
        let l = UILabel()
        l.font = Font.medium14.chooseFont
        return l
    }()
    
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = MKMapType.standard
        mv.isZoomEnabled = true
        mv.isScrollEnabled = true
        return mv
    }()
    
    private lazy var infoTextView: UILabel = {
        let tv = UILabel()
        tv.backgroundColor = Color.systemWhite.chooseColor
        tv.numberOfLines = 0
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initVM()
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initVM() {
        viewModal?.fillDetails = { value in
            self.configure(placeItem: value)
        }
        viewModal?.reloadCollection = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let height = infoTextView.frame.height + infoTextView.frame.origin.y
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.roundCorners(corners: [.topLeft, .topRight ,.bottomLeft], radius: 16)
    }
    
    func configure(placeItem: PlaceItem) {
        cityLbl.text = placeItem.title
        infoTextView.text = placeItem.description
        
//        let formatter = ISO8601DateFormatter()
//        if let date = formatter.date(from:placeItem.visit_date) {
//            let string = date.stringDate
//            dateLbl.text = string
//        }
        
        configureMapView(placeItem: placeItem)
        
    }
    
    func configureMapView(placeItem: PlaceItem) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: placeItem.latitude, longitude: placeItem.longitude)
        annotation.title = placeItem.title
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        mapView.setRegion(region, animated: false)
    }
    
    
    private func setupView() {
        view.backgroundColor = Color.systemWhite.chooseColor
        view.addSubViews(collectionView,pageControl,scrollView,backBtn)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(cityLbl,dateLbl,mapView,infoTextView)
        setupLayout()
    }
    
    private func setupLayout() {
        backBtn.edgesToSuperview(excluding: [.bottom, .right], insets: .left(24) + .top(32))
        backBtn.width(40)
        backBtn.height(40)
        
        collectionView.edgesToSuperview(excluding: [.bottom],usingSafeArea: false)
        collectionView.height(249)
        
        pageControl.bottom(to: collectionView)
        pageControl.centerXToSuperview()
        pageControl.height(44)
        
        scrollView.topToBottom(of: collectionView)
        scrollView.leftToSuperview()
        scrollView.rightToSuperview()
        scrollView.bottomToSuperview()
        
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


extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// size vermemiz gereikyor çünkkü ve genişlik ve yükseklik değerlerinie ihiyacımız var.
        let size = CGSize(width: (collectionView.frame.width), height: 249)
        return size
    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal!.getNumberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionImage", for: indexPath) as? CustomCollectionCell else {return UICollectionViewCell()}
        guard let imageItem = viewModal?.getCellForRowAt(indexpath: indexPath) else {return UICollectionViewCell()}
        
        cell.configure(imageItem: imageItem)
        return cell
    }
    
    
}

extension DetailVC: UIPageViewControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        guard let count = viewModal?.getNumberOfRowsInSection() else {return}
        pageControl.numberOfPages = count
    }
}





