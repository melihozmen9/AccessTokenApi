//
//  Help&SupportVC.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 4.09.2023.
//

import UIKit
import TinyConstraints

class HelpAndSupportVC: UIViewController {
    
    
    let viewModel = HelpAndSupportVM()
    
    private lazy var helpAndSupportBackButton:UIButton = {
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "vector.png")
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backToSettings), for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var helpAndSupportLabel:CustomLabel = {
        let topTitle = CustomLabel()
        topTitle.text = "Help&Support"
        
        return topTitle
    }()
    
    private lazy var whiteView:UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = Color.systemWhite.chooseColor
        
        return whiteView
    }()
    
    private lazy var FaqLAbel:CustomLabel = {
        let faq = CustomLabel()
        
        
        return faq
    }()
    
    private lazy var faqTableView:UITableView = {
       let faqTableView = UITableView()
        faqTableView.dataSource = self
        faqTableView.delegate = self
        faqTableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: "customCell")
        faqTableView.frame = view.bounds
        
        return faqTableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
    }
    
    @objc func backToSettings() {
        
        let settingsPage = MenuVC()
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        
        view.addSubviews(helpAndSupportBackButton, helpAndSupportLabel, whiteView)
        whiteView.addSubviews(FaqLAbel, faqTableView)
        setupLayout()
    }
  
    func setupLayout() {
        
        helpAndSupportBackButton.edgesToSuperview(excluding: [.right, .bottom], insets: .top(32) + .left(24))
        
        helpAndSupportLabel.leadingToTrailing(of: helpAndSupportBackButton, offset: 24)
        helpAndSupportLabel.topToSuperview(offset:19)
        
        whiteView.topToBottom(of: helpAndSupportLabel, offset: 58)
        
        FaqLAbel.leftToSuperview(offset:24)
        FaqLAbel.topToBottom(of: whiteView)
        
        faqTableView.leadingToSuperview(offset:24)
        faqTableView.topToBottom(of: FaqLAbel, offset: 20.51)
    }

}

extension HelpAndSupportVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! HelpSupportTableCell
        
        let topLabel = viewModel.topLabelArray[indexPath.row]
        
        cell.textLabel!.text = topLabel
        
        return cell
    }
    
}

extension HelpAndSupportVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
