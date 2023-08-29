//
//  VisitVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import NVActivityIndicatorView
class VisitVC: UIViewController {
    
    let viewModal = VisitVM()
    
//    private lazy var activity: UIActivityIndicatorView = {
//          let spinner = UIActivityIndicatorView(style: .large)
//          spinner.color = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
//          spinner.hidesWhenStopped = true
//          return spinner
//      }()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    
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
        btn.setImage(UIImage(named: "addNew"), for: .normal)
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
        print("git eklendi")
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: .topLeft, radius: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func addTapped() {
        let vc = AddTravelVC()
        present(vc, animated: true)
    }
    
    func initVM() {
        viewModal.onDataFetch = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activity.startAnimating()
                    print("started")
                } else {
                    self?.activity.stopAnimating()
                    print("ended")
                }
            }
        }

        viewModal.fetchTravels()
        viewModal.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,topLbl,addBtn,activity)
        view1.addSubViews(tableView)
        setupLayout()
    }
    private func setupLayout() {
        topLbl.edgesToSuperview(excluding:[.bottom,.right], insets: .left(24) + .top(24),usingSafeArea: true)
        topLbl.height(52)
        topLbl.width(165)
        
        activity.centerInSuperview()
        activity.height(40)
        activity.width(40)
        
        addBtn.edgesToSuperview(excluding:[.top,.left], insets: .right(16) + .bottom(29),usingSafeArea: true)
        addBtn.width(50)
        addBtn.height(50)
        
        view1.edgesToSuperview( insets: .top(129))
        
        tableView.edgesToSuperview( insets: .top(45) + .right(22) + .left(22) + .bottom(0), usingSafeArea: true)
    }
    
    func pushNav(item: VisitPlace) {
        let detailVC = DetailVC()
        detailVC.viewModal = DetailVM(id: item.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}



extension VisitVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 219
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = viewModal.getObjectForRowAt(indexpath: indexPath) else {return}
        pushNav(item: item)
        
    }
}

extension VisitVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as? VisitCell else {return UITableViewCell()}
        guard let item = viewModal.getObjectForRowAt(indexpath: indexPath) else {return UITableViewCell()}
        let value = item
        cell.configure(item: item)
        return cell
    }
    
    
}
