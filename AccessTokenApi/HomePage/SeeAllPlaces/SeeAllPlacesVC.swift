//
//  PopularPlacesVC.swift
//  AccessTokenApi
//
//  Created by Mert Atakan on 1.09.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class SeeAllPlacesVC: UIViewController {
    
    var fromWhere:String?
    let seeAllPlacesVM = SeeAllPlacesVM()
    
    private lazy var backButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.font = Font.semibold32.chooseFont
        label.textColor = Color.white.chooseColor
        return label
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Color.systemWhite.chooseColor
        return containerView
    }()
    
    private lazy var ascendingDescendingButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AscendingPlace"), for: .normal)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 70, left: 24, bottom: 0, right: 24)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(SeeAllPlacesCustomCell.self, forCellWithReuseIdentifier: "PopularPlacesCustomCell")
        return cv
    }()
    
    override func viewWillLayoutSubviews() {
        containerView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setupViews()
    }
    
    private func setupViews() {
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        
        
        self.containerView.addSubviews(collectionView, ascendingDescendingButton)
        
        view.addSubviews(backButton,
                         headerLabel,
                         containerView)
        
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        backButton.edgesToSuperview(excluding: [.bottom, .right], insets: .left(24) + .top(32), usingSafeArea: true)
        backButton.height(22)
        backButton.width(24)
        
        headerLabel.topToSuperview(offset:20, usingSafeArea: true)
        headerLabel.leadingToTrailing(of: backButton, offset: 24)
        
        containerView.topToBottom(of: headerLabel, offset: 60)
        containerView.edgesToSuperview(excluding: [.top])
        
        ascendingDescendingButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(24) + .right(24))
        ascendingDescendingButton.height(22)
        ascendingDescendingButton.width(25)
        
        collectionView.edgesToSuperview()
        
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getData() {
        if fromWhere == "popularPlaces" {
            headerLabel.text = "Popular Places"
            seeAllPlacesVM.getPopularPlaces {
                self.collectionView.reloadData()
            }
            
        } else if fromWhere == "myAddedPlaces" {
            headerLabel.text = "My Added Places"
            seeAllPlacesVM.getMyAddedPlaces {
                self.collectionView.reloadData()
            }
            
        } else if fromWhere == "lastPlaces" {
            headerLabel.text = "Last Places"
            seeAllPlacesVM.getLastPlaces {
                self.collectionView.reloadData()
            }
        }
    }
}

extension SeeAllPlacesVC:UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (collectionView.frame.width-48), height: 90)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}



extension SeeAllPlacesVC:UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if fromWhere == "popularPlaces" {
            count = seeAllPlacesVM.countOfPopularPlaces()
        } else if fromWhere == "myAddedPlaces" {
            count = seeAllPlacesVM.countOfMyAddedPlaces()
        } else if fromWhere == "lastPlaces" {
            count = seeAllPlacesVM.countOfLastPlaces()
        }
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularPlacesCustomCell", for: indexPath) as? SeeAllPlacesCustomCell else { return UICollectionViewCell() }
        
        if fromWhere == "popularPlaces" {
            guard let item = seeAllPlacesVM.getPopularPlace(index: indexPath.row) else { return UICollectionViewCell() }
            cell.configure(item: item)
        } else if fromWhere == "myAddedPlaces" {
            guard let item = seeAllPlacesVM.getMyAddedPlace(index: indexPath.row) else { return UICollectionViewCell() }
            cell.configure(item: item)
        } else if fromWhere == "lastPlaces" {
            guard let item = seeAllPlacesVM.getLastPlace(index: indexPath.row) else { return UICollectionViewCell() }
            cell.configure(item: item)
        }
        return cell
    }
    
    
}
