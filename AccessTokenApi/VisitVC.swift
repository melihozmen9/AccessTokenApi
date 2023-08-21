//
//  VisitVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
class VisitVC: UIViewController {
    let viewModal = VisitVM()
    
    private lazy var topLbl: UILabel = {
        let l = UILabel()
        l.layer.cornerRadius = 3
        l.text = "My Visits"
        l.font = Font.semibold24.chooseFont
        l.textColor = Color.white.chooseColor
        return l
    }()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Color.systemWhite.chooseColor
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.register(VisitCell.self, forCellReuseIdentifier: "VisitCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupView()
        initVM()
    }
    
    func initVM() {
        viewModal.fetchTravels()
        viewModal.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: .topLeft, radius: 80)
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,topLbl,addBtn)
        view1.addSubViews(tableView)
        setupLayout()
    }
    private func setupLayout() {
        topLbl.edgesToSuperview(excluding:[.bottom,.right], insets: .left(24) + .top(24),usingSafeArea: true)
        topLbl.height(52)
        topLbl.width(165)
        
        addBtn.edgesToSuperview(excluding:[.bottom,.left], insets: .right(24) + .top(24),usingSafeArea: true)
        addBtn.width(30)
        addBtn.height(30)
        view1.edgesToSuperview( insets: .top(129))
        
        tableView.edgesToSuperview( insets: .top(45) + .right(22) + .left(22) + .bottom(0), usingSafeArea: true)
    }
    
    @objc func addTapped() {
        let vc = AddTravelVC()
        present(vc, animated: true)
    }


}



extension VisitVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 219
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        guard let item = viewModal.getCellForRowAt(indexpath: indexPath) else {return}
        detailVC.configure(travelItem: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension VisitVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as? VisitCell else {return UITableViewCell()}
        guard let item = viewModal.getCellForRowAt(indexpath: indexPath) else {return UITableViewCell()}
        cell.configure(travelItem: item)
        return cell
    }
    
    
}
