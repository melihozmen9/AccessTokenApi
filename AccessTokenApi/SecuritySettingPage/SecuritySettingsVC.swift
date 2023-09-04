//
//  SecuritySettingsVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import UIKit
import TinyConstraints


class SecuritySettingsVC: UIViewController {
    
    let viewModal = SecuritySettingsVM()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "vector"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold32.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Security Settings"
        return l
    }()
    
//    private lazy var infoLbl1: UILabel = {
//        let l = UILabel()
//        l.text = "Change Password"
//        l.font = Font.bold16.chooseFont
//        l.textColor = Color.systemGreen.chooseColor
//        return l
//    }()
//
//    private lazy var passwordTf1: CustomView = {
//        let v = CustomView()
//        v.Lbl.text = "New Password"
//        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
//        return v
//    }()
//
//    private lazy var passwordTf2: CustomView = {
//        let v = CustomView()
//        v.Lbl.text = "New Password Confirm"
//        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
//        return v
//    }()
//
//    private lazy var infoLbl2: UILabel = {
//        let l = UILabel()
//        l.text = "Privacy"
//        l.font = Font.bold16.chooseFont
//        l.textColor = Color.systemGreen.chooseColor
//        return l
//    }()
//
//    private lazy var cameraPermission: CustomSwitchView = {
//        let v = CustomSwitchView()
//        v.Lbl.text = "Camera"
//        v.switchView.addTarget(self, action: #selector(cameraToggled), for: .valueChanged)
//        v.switchView.isOn = viewModal.setPermissionToggle(forKey: "CameraPermission")
//        return v
//    }()
//
//    private lazy var libraryPermission: CustomSwitchView = {
//        let v = CustomSwitchView()
//        v.Lbl.text = "Photo Library"
//        v.switchView.addTarget(self, action: #selector(libraryToggled), for: .valueChanged)
//        v.switchView.isOn = viewModal.setPermissionToggle(forKey: "LibraryPermission")
//        return v
//    }()
//
//    private lazy var locationPermission: CustomSwitchView = {
//        let v = CustomSwitchView()
//        v.Lbl.text = "Location"
//        v.switchView.addTarget(self, action: #selector(locationToggled), for: .valueChanged)
//        v.switchView.isOn = viewModal.setPermissionToggle(forKey: "LocationPermission")
//        return v
//    }()
    
    private lazy var saveBtn: CustomButton = {
        let btn = CustomButton()
        btn.layer.cornerRadius = 3
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SecurityCell.self, forCellReuseIdentifier: "cell")
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initVM()
        
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func saveTapped() {
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Switch fonksiyonları
    @objc func cameraToggled(sender: UISwitch) {
        if sender.isOn {
            openAppSettings()
        } else {
            openAppSettings()
        }
        self.viewModal.checkCameraPermission()
        sender.isOn = self.viewModal.setPermissionToggle(forKey: "CameraPermission")
    }
    
    
    
    @objc func libraryToggled(sender: UISwitch) {
        if sender.isOn {
            openAppSettings()
        } else {
            openAppSettings()
            
        }
        self.viewModal.checkLibraryPermission()
        sender.isOn = self.viewModal.setPermissionToggle(forKey: "LibraryPermission")
    }
    
    @objc func locationToggled(sender: UISwitch) {
        if sender.isOn {
            openAppSettings()
        } else {
            openAppSettings()
            
        }
        self.viewModal.checkLocationPermission()
        sender.isOn = self.viewModal.setPermissionToggle(forKey: "LocationPermission")
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func initVM() {
        viewModal.checkAllPermissions()
    }
    
    
    //MARK: - Ayarlara yönlendiren fonksiyon
    
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,tableView,backButton,titleLbl,saveBtn)
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
        view1.topToBottom(of: titleLbl, offset: 58)
        
        tableView.edgesToSuperview(excluding:[.bottom,.top] ,insets: .right(24) + .left(24))
        tableView.bottomToTop(of: saveBtn, offset: -20)
        tableView.top(to: view1, offset: 44)
        
        saveBtn.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(18))
        saveBtn.height(54)
        
    }
    
}

extension SecuritySettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        headerView.backgroundColor = .clear // Başlık arkaplan rengi
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width - 20, height: 20))
        // Başlık metni
        if section == 0 {
            label.text = "Change Password"
        } else if section == 1 {
            label.text = "Privacy"
        }
        label.textColor = Color.systemGreen.chooseColor // Başlık metin rengi
        
        headerView.addSubview(label)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // Başlık yüksekliği
    }
}

extension SecuritySettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModal.settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SecurityCell else {return UITableViewCell()}
        cell.configure(section: indexPath.section,data: viewModal.settingsArray[indexPath.section][indexPath.row])
        return cell
    }
}
