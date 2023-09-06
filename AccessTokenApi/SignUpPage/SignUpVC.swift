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
    var isEmail = false
    var isUsername = false
    var isPassword1 = false
    var isPassword2 = false
    
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
        l.font = Font.bold36.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Sign Up"
        return l
    }()
    
    private lazy var usernameView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Username"
        v.Tf.delegate = self
        v.Tf.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Email"
        v.Tf.delegate = self
        v.Tf.attributedPlaceholder = NSAttributedString(string: "developer@bilgeadam.com", attributes: v.attributes)
        return v
    }()
    
    private lazy var pass1View: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Password"
        v.Tf.delegate = self
        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        v.Tf.isSecureTextEntry = true
        return v
    }()
    
    private lazy var pass2View: CustomView = {
        let v = CustomView()
        v.Lbl.text = "Password Confirm"
        v.Tf.delegate = self
        v.Tf.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        v.Tf.isSecureTextEntry = true
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
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: .topLeft, radius: 80)
        lgnBtn.backgroundColor = Color.systemgray.chooseColor
        lgnBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
                self.showPositiveAlert()
            }
        })
    }
    
    private func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,titleLbl,backButton)
        view1.addSubViews(stackView,lgnBtn)
        stackView.addArrangedSubviews(usernameView)
        stackView.addArrangedSubviews(emailView)
        stackView.addArrangedSubviews(pass1View)
        stackView.addArrangedSubviews(pass2View)
        setupLayout()
    }
    
    private func setupLayout() {
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(23),usingSafeArea: true)
        backButton.height(21)
        backButton.width(24)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .left], insets: .top(19) + .right(24),usingSafeArea: true)
        titleLbl.leftToRight(of: backButton, offset: 77)
        titleLbl.height(48)
        
        view1.edgesToSuperview(excluding: [.top])
        view1.topToBottom(of: titleLbl, offset: 58)
        
        stackView.edgesToSuperview( insets: .top(72) + .left(24) + .right(24) + .bottom(279))
        
        lgnBtn.topToBottom(of: stackView, offset: 202)
        lgnBtn.edgesToSuperview( excluding: [.top],insets: .left(24) + .right(24) + .bottom(23))
    }
    
    
    func showPositiveAlert() {
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidUsername(_ name: String) -> Bool {
        let allowedCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        let isAlphabetic = name.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
        let isLengthValid = name.count >= 6
        
        if isAlphabetic && isLengthValid {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let letterCharacterSet = NSCharacterSet.letters
        let digitCharacterSet = NSCharacterSet.decimalDigits
        
        let containsLetter = password.rangeOfCharacter(from: letterCharacterSet as CharacterSet) != nil
        let containsDigit = password.rangeOfCharacter(from: digitCharacterSet as CharacterSet) != nil
        
        let isLengthValid = password.count >= 6
        
        return containsLetter && containsDigit && isLengthValid
    }
    
    func updateLoginButtonState() {
        let passwordsMatch = pass1View.Tf.text == pass2View.Tf.text
        
        if isEmail && isUsername && isPassword1 && isPassword2 && passwordsMatch {
            lgnBtn.isEnabled = true
            lgnBtn.backgroundColor = Color.systemGreen.chooseColor
        } else {
            lgnBtn.isEnabled = false
            lgnBtn.backgroundColor = Color.systemgray.chooseColor
        }
    }
    
}

extension SignUpVC : UITextFieldDelegate {
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        updateLoginButtonState()
    //    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateLoginButtonState()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == emailView.Tf {
            
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            
            isEmail = isValidEmail(updatedText)
            print(isEmail)
            
        }
        
        if textField == usernameView.Tf {
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            
            isUsername = isValidUsername(updatedText)
            print(isUsername)
            
        }
        
        if textField == pass1View.Tf {
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            isPassword1 = isValidPassword(updatedText)
            print(isPassword1)
        }
        
        if textField == pass2View.Tf {
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            isPassword2 = isValidPassword(updatedText)
            print(isPassword2)
            
        }
        
        return true
    }
}

