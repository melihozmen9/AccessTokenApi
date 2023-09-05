//
//  HomeVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
class HomeVC: UIViewController {
    
    let viewModal = HomeVM()
    
    private lazy var topImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "homeTopImage")
        return iv
    }()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Color.systemWhite.chooseColor
        tv.delegate = self
        tv.dataSource = self
        tv.register(HomeTableCell.self, forCellReuseIdentifier: "tableCell")
        return tv
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func showDetail(_ button:UIButton){
        let seeAllVC = SeeAllPlacesVC()
        
        if button.tag == 0 {
            seeAllVC.fromWhere = "popularPlaces"
        } else if button.tag == 1 {
            seeAllVC.fromWhere = "myAddedPlaces"
        } else if button.tag == 2 {
            seeAllVC.fromWhere = "newPlaces"
        }
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    func initVM() {
        //viewModal.getAddedPlaces()
       // viewModal.getPopularPlaces()
        viewModal.getLastPlaces()
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        self.view.addSubviews(view1,topImageview)
        view1.addSubviews(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        topImageview.edgesToSuperview(excluding: [.bottom,.right], insets: .top(28) + .left(16),usingSafeArea: true)
        topImageview.height(62)
        topImageview.width(172)
        
        view1.topToBottom(of: topImageview, offset: 35)
        view1.edgesToSuperview(excluding: [.top])
        
        tableView.top(to: view1,offset: 55)
        tableView.edgesToSuperview(excluding: [.top], insets: .left(24))
    }
  

}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 52))
        headerView.backgroundColor = Color.systemWhite.chooseColor
            let label = UILabel()
            label.frame = CGRect.init(x: 0, y: 20, width: headerView.frame.width-10, height: 30)
        label.text = viewModal.getHeaderNameForSection(section: section)
        label.font = Font.semibold20.chooseFont
        label.textColor = Color.systemblack.chooseColor
        
        let button = UIButton(type: .system)
           button.setTitle("See All", for: .normal)
        button.setTitleColor(Color.systemBlue.chooseColor, for: .normal)
        button.titleLabel?.font = Font.semibold14.chooseFont
           button.frame = CGRect(x: 303, y: 28, width: 47, height: 21)
           button.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)

           button.tag = section
            
            headerView.addSubview(label)
            headerView.addSubview(button)
        
            return headerView
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 52
    }
   
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
      
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
