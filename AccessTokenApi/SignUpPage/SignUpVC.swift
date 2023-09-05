//
//  SignUpVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
class SignUpVC: UIViewController {
    
    let viewModal = RegisterVM()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var usernameView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Username"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Email"
        v.Tf.attributedPlaceholder = NSAttributedString(string: "developer@bilgeadam.com", attributes: v.attributes)
        return v
    }()
    
    private lazy var pass1View: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Password"
        v.Tf.delegate = self
        return v
    }()
    
    private lazy var pass2View: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Password Confirm"
        v.Tf.delegate = self
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var lgnBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("Register", for: .normal)
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        isEnabled()
    }
    
    @objc func registerTapped() {
        guard let name = usernameView.Tf.text, let email = emailView.Tf.text, let password1 = pass1View.Tf.text,let _ = pass2View.Tf.text else {return}
        
        let body = ["full_name":name,"email":email,"password":password1]
        
        viewModal.register(params: body, handler: { response in
            if response.status == "fail" {
                self.showErrorAlert(message: """
                                        Lütfen tüm bilgileri doldurunuz.
                                        Email formatına ve şifrenizin en az altı
                                        karakterden oluşmasına dikkat edin.
                                        """)
            } else {
                self.showAlert()
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: .topLeft, radius: 80)
    }
    
    private func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1)
        view1.addSubViews(stackView,lgnBtn)
        stackView.addArrangedSubviews(usernameView)
        stackView.addArrangedSubviews(emailView)
        stackView.addArrangedSubviews(pass1View)
        stackView.addArrangedSubviews(pass2View)
        setupLayout()
        navBarDesign()
    }
    
    func navBarDesign() {
        title = "Sign Up"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.bold36.chooseFont,
                                                                        .foregroundColor: Color.white.chooseColor
        ]
        let leftButton = UIBarButtonItem(image: UIImage(named: "vector"), style: .plain, target: self, action: #selector(registerTapped))
        leftButton.tintColor = Color.white.chooseColor
        self.navigationItem.leftBarButtonItem  = leftButton
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    private func setupLayout() {
        view1.edgesToSuperview(insets: .top(124))
        
        stackView.edgesToSuperview( insets: .top(72) + .left(24) + .right(24) + .bottom(279))
        
        lgnBtn.topToBottom(of: stackView, offset: 202)
        lgnBtn.edgesToSuperview( excluding: [.top],insets: .left(24) + .right(24) + .bottom(23))
    }
    
 
    
    
    func isEnabled() {
        if pass1View.Tf.text == "" || pass2View.Tf.text == "" && pass1View.Tf.text !=  pass2View.Tf.text {
            lgnBtn.isEnabled = false
            lgnBtn.backgroundColor = Color.systemgray.chooseColor
        } else {
            lgnBtn.isEnabled = true
            lgnBtn.backgroundColor = Color.systemGreen.chooseColor
        }
    }
    
    func showAlert() { // bunun olumsuz fonksiyonu'da yaz. gelen error'u string olarak mesaja yazdır.
        let alert = UIAlertController(title: "Tebrikler, Kaydoldunuz", message: "Şimdi sisteme giriş yapabilirsin.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Login sayfasına git", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    func showErrorAlert(message:String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "tamam", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension SignUpVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEnabled()
    }
}
