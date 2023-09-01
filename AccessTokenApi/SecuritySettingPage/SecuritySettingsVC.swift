//
//  SecuritySettingsVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import UIKit
import TinyConstraints
import AVFoundation
import Photos
import CoreLocation

class SecuritySettingsVC: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
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
        l.text = "Security Settings"
        return l
    }()
    
    private lazy var infoLbl1: UILabel = {
        let l = UILabel()
        l.text = "Change Password"
        l.font = Font.bold16.chooseFont
        l.textColor = Color.systemGreen.chooseColor
        return l
    }()
    
    private lazy var passwordTf1: CustomView = {
        let v = CustomView()
        v.Lbl.text = "New Password"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        return v
    }()
    
    private lazy var passwordTf2: CustomView = {
        let v = CustomView()
        v.Lbl.text = "New Password Confirm"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        return v
    }()
    
    private lazy var infoLbl2: UILabel = {
        let l = UILabel()
        l.text = "Privacy"
        l.font = Font.bold16.chooseFont
        l.textColor = Color.systemGreen.chooseColor
        return l
    }()
    
    private lazy var cameraPermission: CustomSwitchView = {
        let v = CustomSwitchView()
        v.Lbl.text = "Camera"
        v.switchView.addTarget(self, action: #selector(cameraToggled), for: .valueChanged)
        return v
    }()
    
    private lazy var libraryPermission: CustomSwitchView = {
        let v = CustomSwitchView()
        v.Lbl.text = "Photo Library"
        v.switchView.addTarget(self, action: #selector(libraryToggled), for: .valueChanged)
        return v
    }()
    
    private lazy var locationPermission: CustomSwitchView = {
        let v = CustomSwitchView()
        v.Lbl.text = "Location"
        v.switchView.addTarget(self, action: #selector(locationToggled), for: .valueChanged)
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
       checkAllPermissions()
       
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func saveTapped() {
        
    }
    
    @objc func cameraToggled(sender: UISwitch) {
        if sender.isOn {
//        openAppSettings()
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                      if granted {
//                          // Kullanıcı izni verdi.
//                      } else {
//                          // Kullanıcı izni vermedi.
//                      }
                  //}
            // keza burada kullanıcı ayarlara gidip ayarını değiştirmeyebilir. kontroleden ve user'dault'u guncelleen fonksiyon burada calışmalı mı?
              } else {
                  openAppSettings()
              }
    }
    
//MARK: - Switch fonksiyonları
    
    @objc func libraryToggled(sender: UISwitch) {
        if sender.isOn {
        openAppSettings()
              } else {
                  openAppSettings()
                  
              }
    }
    
    @objc func locationToggled(sender: UISwitch) {
        if sender.isOn {
        openAppSettings()
              } else {
                  openAppSettings()
              }
    }
    //MARK: - İzinlerin durumunu öğrenme ve userDefaults'a kaydetme.
    
    func checkAllPermissions() {
        checkCameraPermission()
        checkLocationPermission()
        checkLibraryPermission()
    }
    
    func checkLibraryPermission() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        var isLibraryPermissionGranted = false

        switch authorizationStatus {
        case .authorized:
            print("Kullanıcı fotoğraf kitaplığı izni verdi.")
            isLibraryPermissionGranted = true
        case .denied:
            print("Kullanıcı fotoğraf kitaplığı izni vermedi.")
        case .restricted:
            print("Fotoğraf kitaplığı izni kısıtlandı.")
        case .notDetermined:
            print("Fotoğraf kitaplığı izni henüz seçilmedi.")
        @unknown default:
            print("Bilinmeyen izin durumu.")
        }

        UserDefaults.standard.set(isLibraryPermissionGranted, forKey: "LibraryPermission")
        setLibraryPermissionToggle()
    }
    
   
    
    func checkLocationPermission() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        var isLocationPermissionGranted = false
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Kullanıcı konum izni verdi.")
            isLocationPermissionGranted = true
        case .denied:
            print("Kullanıcı konum izni vermedi.")
            isLocationPermissionGranted = false
        case .restricted:
            print("Konum izni kısıtlandı.")
            isLocationPermissionGranted = false
        case .notDetermined:
            print("Konum izni henüz seçilmedi.")
            isLocationPermissionGranted = false
        @unknown default:
            print("Bilinmeyen izin durumu.")
            isLocationPermissionGranted = false
        }
        UserDefaults.standard.set(isLocationPermissionGranted, forKey: "LocationPermission")
        setLocationPermissionToggle()
    }
  

    func checkCameraPermission() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        var isCameraPermissionGranted = false
        switch authorizationStatus {
        case .authorized:
            print("Kullanıcı kamera izni verdi.")
            isCameraPermissionGranted = true
        case .denied:
            print("Kullanıcı kamera izni vermedi.")
            isCameraPermissionGranted = false
        case .restricted:
            print("Kamera izni kısıtlandı.")
            isCameraPermissionGranted = false
        case .notDetermined:
            print("Kamera izni henüz seçilmedi.")
            isCameraPermissionGranted = false
        @unknown default:
            print("Bilinmeyen izin durumu.")
            isCameraPermissionGranted = false
        }
        UserDefaults.standard.set(isCameraPermissionGranted, forKey: "CameraPermission")
        setCameraPermissionToggle()
    }
    
    //MARK: - Switchlerin off/on statülerini ayarlama
    func setCameraPermissionToggle() {
           let isCameraPermissionGranted = UserDefaults.standard.bool(forKey: "CameraPermission")
        cameraPermission.switchView
            .isOn = isCameraPermissionGranted
       }
    func setLibraryPermissionToggle() {
           let isLibraryPermissionGranted = UserDefaults.standard.bool(forKey: "LibraryPermission")
        libraryPermission.switchView.isOn = isLibraryPermissionGranted
       }
    
    func setLocationPermissionToggle() {
           let isLocationPermissionGranted = UserDefaults.standard.bool(forKey: "LocationPermission")
        locationPermission.switchView
            .isOn = isLocationPermissionGranted
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
        view.addSubViews(view1,infoLbl1,infoLbl2,cameraPermission,libraryPermission,locationPermission,passwordTf1,passwordTf2,backButton,titleLbl,saveBtn)
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
        
        infoLbl1.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(130))
        infoLbl1.top(to: view1, offset: 44)
        infoLbl1.height(20)
        
        passwordTf1.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(24))
        passwordTf1.topToBottom(of: infoLbl1, offset: 8)
        passwordTf1.height(74)
        
        passwordTf2.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(24))
        passwordTf2.topToBottom(of: passwordTf1, offset: 8)
        passwordTf2.height(74)
        
        infoLbl2.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(130))
        infoLbl2.topToBottom(of: passwordTf2, offset: 24)
        infoLbl2.height(20)
        
        cameraPermission.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(24))
        cameraPermission.topToBottom(of: infoLbl2, offset: 8)
        cameraPermission.height(74)
        
        libraryPermission.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(24))
        libraryPermission.topToBottom(of: cameraPermission, offset: 8)
        libraryPermission.height(74)
        
        locationPermission.edgesToSuperview(excluding: [.top, .bottom], insets: .left(24) + .right(24))
        locationPermission.topToBottom(of: libraryPermission, offset: 8)
        locationPermission.height(74)
        
        saveBtn.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(18))
        saveBtn.height(54)
        
    }

}
