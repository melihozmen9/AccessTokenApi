//
//  EditProfileVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import UIKit
import TinyConstraints
class EditProfileVC: UIViewController {
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var backButton: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "vector")
        return iv
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold32.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Edit Profile"
        return l
    }()
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = iv.frame.size.width / 2
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "person.fill")
        return iv
    }()
    
    private lazy var changePhotoBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(Color.systemBlue.chooseColor, for: .normal)
        btn.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold24.chooseFont
        l.textColor = Color.systemblack.chooseColor
        l.textAlignment = .center
        l.text = "Delete Later"
        return l
    }()
    
    private lazy var dateView: InfoCustomView = {
        let v = InfoCustomView()
        v.layer.cornerRadius = 16
        v.backgroundColor = Color.white.chooseColor
        v.imageview.image = UIImage(named: "dateIcon")
        v.Lbl.text = "30 Haziran 2023"
        return v
    }()
    
    private lazy var positionView: InfoCustomView = {
        let v = InfoCustomView()
        v.layer.cornerRadius = 16
        v.backgroundColor = Color.white.chooseColor
        v.imageview.image = UIImage(named: "positionIcon")
        v.Lbl.text = "Admin"
        return v
    }()
    
    private lazy var nameView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Full Name"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Email"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var saveBtn: CustomButton = {
        let btn = CustomButton()
        btn.layer.cornerRadius = 3
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
      
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func changePhotoTapped() {
        
    }
    
    @objc func saveTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        self.view.addSubViews(backButton, titleLbl, view1, imageview, changePhotoBtn, nameLbl, dateView, positionView, nameView, emailView, saveBtn)
        setupLayout()
    }
    private func setupLayout() {
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(23),usingSafeArea: true)
        backButton.height(21)
        backButton.width(24)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .left], insets: .top(19) + .right(24),usingSafeArea: true)
        titleLbl.leftToRight(of: backButton, offset: 24)
        titleLbl.height(48)
        
        view1.edgesToSuperview(excluding: [.top])
        view1.topToBottom(of: titleLbl, offset: 54)
        
        imageview.top(to: view1, offset: 24)
        imageview.edgesToSuperview(excluding: [.bottom, .top], insets: .left(135) + .right(135))
        imageview.height(120)
        imageview.width(120)
        
        changePhotoBtn.topToBottom(of: imageview, offset: 7)
        changePhotoBtn.edgesToSuperview(excluding: [.bottom, .top], insets: .left(100) + .right(100))
        changePhotoBtn.height(18)

        nameLbl.topToBottom(of: changePhotoBtn, offset: 7)
        nameLbl.edgesToSuperview(excluding: [.bottom, .top], insets: .left(50) + .right(50))
        nameLbl.height(36)

        dateView.topToBottom(of: nameLbl, offset: 21)
        dateView.leftToSuperview(offset: 24)
        dateView.height(52)
        dateView.width(164)

        positionView.leftToRight(of: dateView, offset: 16)
        positionView.topToBottom(of: nameLbl, offset: 21)
        positionView.height(52)
        positionView.width(164)

        nameView.topToBottom(of: dateView, offset: 20)
        nameView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        nameView.height(74)

        emailView.topToBottom(of: nameView, offset: 16)
        emailView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        emailView.height(74)
        
        saveBtn.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(99))
        saveBtn.height(51)
    }

}
