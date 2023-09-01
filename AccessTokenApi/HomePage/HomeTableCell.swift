//
//  HomeTableCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 1.09.2023.
//

import UIKit
import TinyConstraints
class HomeTableCell: UITableViewCell {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.backgroundColor = Color.systemWhite.chooseColor
        return cv
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = Color.systemWhite.chooseColor
        self.contentView.addSubviews(collectionView)
        setupLayout()
    }
    private func setupLayout() {
        collectionView.edgesToSuperview()
    }
    
}


extension HomeTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// size vermemiz gereikyor çünkkü ve genişlik ve yükseklik değerlerinie ihiyacımız var.
        let size = CGSize(width: 309, height: (collectionView.frame.height))
        return size
    }
}

extension HomeTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) 
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
