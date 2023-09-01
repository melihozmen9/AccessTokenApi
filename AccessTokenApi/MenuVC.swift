//
//  MenuVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class MenuVC: UIViewController {
    
    let viewModel = MenuVM()
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = Color.systemWhite.chooseColor
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 135, y: 149, width: 120, height: 120))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: URL(string: "https://cdn.britannica.com/48/194248-050-4EE825CF/Bruce-Willis-2013.jpg"))
        
        return imageView
    }()
    
    private lazy var label:CustomLabel = {
        let label = CustomLabel()
        label.text = "Bruce Wills"
        label.textColor = .black
     //   label.fontType.chooseFont
        
        return label
    }()
    
    private lazy var difButton:UIButton = {
        let difButton = UIButton()
        difButton.setTitleColor(#colorLiteral(red: 0, green: 0.7960889935, blue: 0.9382097721, alpha: 1), for: .normal)
        difButton.setTitle("Edit Profile", for: .normal)
        difButton.titleLabel?.font = Font.regular12.chooseFont
       
        return difButton
    }()
    
    private lazy var collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
   //     layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
  //      cv.backgroundColor = .clear
        cv.backgroundColor = .gray
        cv.register(CustomCvCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    
    private lazy var titlelbl:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Font.bold30.chooseFont.fontName, size: Font.bold30.chooseFont.pointSize)
        
        return titleLabel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
        
            }
    
    override func viewDidLayoutSubviews() {
        
        view1.roundCorners(corners: .topLeft, radius: 80)
        
    }
    
    func setupView() {
        
        self.view.addSubviews(titlelbl,view1)
        view1.addSubviews(imageView, label, difButton, collectionView)
        setupLayout()
    }

    func setupLayout() {
        
//        titlelbl.leading(to: view.safeAreaLayoutGuide, offset: 20)
//        titlelbl.top(to: view.safeAreaLayoutGuide, offset: 23)
        titlelbl.edgesToSuperview(excluding: [.bottom, .right], insets: .left(20) + .top(23), usingSafeArea: true)
        titlelbl.height(48)
        titlelbl.width(134)
        
        view1.edgesToSuperview(insets: .top(125), usingSafeArea: true)
    //  view1.topToBottom(of: titlelbl, offset: 54)
        
        
        imageView.top(to: view1, offset: 24)
        imageView.height(120)
        imageView.width(120)
        imageView.centerXToSuperview()
        
        label.topToBottom(of: imageView, offset: 8)
        label.centerXToSuperview()
        label.height(24)
        label.width(94)
        
        difButton.topToBottom(of: label)
        difButton.centerXToSuperview()
        difButton.height(18)
        difButton.width(62)
        
        collectionView.topToBottom(of: difButton, offset: 16)
        collectionView.bottomToSuperview(offset: -54)
        collectionView.leftToSuperview(offset:16)
        collectionView.trailingToSuperview(offset:16)
        
    }

}

extension MenuVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.labels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCvCell else  {return UICollectionViewCell()}
        
        let images = viewModel.getImageForRow(indexpath: indexPath)
        let labels = viewModel.getLabelForRow(indexpath: indexPath)
        let images2 = viewModel.getImageForRow2(indexpath: indexPath)
        
        cell.configure(imgView1: images, lbl: labels, imgView2: images2)
        
        return cell
    }
    
    
}
extension MenuVC:UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 9, left: 16, bottom: 0, right: 16)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell'e basıldı")
        let nav = SecuritySettingsVC()
        navigationController?.pushViewController(nav, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 48)
        }
    
}
