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
        topTitle.font = Font.semibold32.chooseFont
        topTitle.textColor = Color.white.chooseColor
        
        return topTitle
    }()
    
    private lazy var whiteView:UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = Color.systemWhite.chooseColor
        
        return whiteView
    }()
    
    private lazy var faqLabel:UILabel = {
        let faq = UILabel()
        faq.text = "FAQ"
        faq.textColor = Color.systemGreen.chooseColor
        faq.font = Font.semibold24.chooseFont
        
        return faq
    }()
    
    private lazy var faqTableView:UITableView = {
       let faqTableView = UITableView()
        faqTableView.dataSource = self
        faqTableView.delegate = self
        faqTableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: "customCell")
        faqTableView.isScrollEnabled = false
//        faqTableView.sectionHeaderHeight = 10.0 // Üst boşluğu ayarlayın
//        faqTableView.sectionFooterHeight = 10.0
        
        return faqTableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        whiteView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func backToSettings() {
        
        let settingsPage = MenuVC()
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        
        view.addSubviews(helpAndSupportBackButton, helpAndSupportLabel, whiteView)
        whiteView.addSubviews(faqLabel, faqTableView)
        setupLayout()
    }
  
    func setupLayout() {
        
        helpAndSupportBackButton.edgesToSuperview(excluding: [.right, .bottom], insets: .top(32) + .left(24), usingSafeArea: true)
        
        helpAndSupportLabel.leadingToTrailing(of: helpAndSupportBackButton, offset: 24)
        helpAndSupportLabel.topToSuperview(offset:19, usingSafeArea: true)
        
        whiteView.edgesToSuperview(insets: .top(125),usingSafeArea: true)
        whiteView.bottomToSuperview()
        
        faqLabel.top(to: whiteView, offset: 44)
        faqLabel.leadingToSuperview(offset:24)
        
        faqTableView.leadingToSuperview(offset:24)
        faqTableView.topToBottom(of: faqLabel, offset: 20.51)
        faqTableView.centerXToSuperview()
        faqTableView.bottomToSuperview(offset:-89)
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
//        cell.sizeToFit()
//        cell.height(cell.frame.height)
        return cell
    }
    
}

extension HelpAndSupportVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75

    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//            headerView.backgroundColor = .clear // Üst boşluğun arka plan rengini ayarlayın
//            return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.backgroundColor = UIColor.clear
//        let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, 70))
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
//                whiteRoundedView.layer.masksToBounds = false
//                whiteRoundedView.layer.cornerRadius = 3.0
//                whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
//                whiteRoundedView.layer.shadowOpacity = 0.5
//                cell.contentView.addSubview(whiteRoundedView)
//                cell.contentView.sendSubviewToBack(whiteRoundedView)
//    }
}
