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
    
    let visitViewModal = VisitVM()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.text = "My Visits"
        label.font = Font.semibold24.chooseFont
        label.textColor = Color.white.chooseColor
        return label
    }()
    
    private lazy var addVisitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.setImage(UIImage(named: "addNew"), for: .normal)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Color.systemWhite.chooseColor
        return containerView
    }()
    
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.systemWhite.chooseColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VisitCell.self, forCellReuseIdentifier: "VisitCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func addTapped() {
        let vc = AddTravelVC(latitude: 0, longitude: 0)
        present(vc, animated: true)
    }
    
    func initVM() {
        visitViewModal.onDataFetch = { [weak self] isLoading in
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

        visitViewModal.fetchTravels {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(containerView,headerLabel,addVisitButton,activity)
        containerView.addSubViews(tableView)
        setupLayout()
    }
    private func setupLayout() {
        headerLabel.edgesToSuperview(excluding:[.bottom,.right], insets: .left(24) + .top(24),usingSafeArea: true)
        headerLabel.height(52)
        headerLabel.width(165)
        
        activity.centerInSuperview()
        activity.height(40)
        activity.width(40)
        
        addVisitButton.edgesToSuperview(excluding:[.top,.left], insets: .right(16) + .bottom(29),usingSafeArea: true)
        addVisitButton.width(50)
        addVisitButton.height(50)
        
        containerView.edgesToSuperview( insets: .top(129))
        
        tableView.edgesToSuperview( insets: .top(45) + .right(22) + .left(22) + .bottom(0), usingSafeArea: true)
    }
    
    func pushNav(itemID: String) {
        let detailVC = DetailVC()
        detailVC.visitId = itemID
        navigationController?.pushViewController(detailVC, animated: true)
        
        print("x")
    }
}


extension VisitVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 219
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = visitViewModal.getObjectForRowAt(indexpath: indexPath) else {return}
        pushNav(itemID: item.id)
        
    }
}

extension VisitVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitViewModal.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as? VisitCell else {return UITableViewCell()}
        guard let item = visitViewModal.getObjectForRowAt(indexpath: indexPath) else {return UITableViewCell()}
        cell.configure(item: item)
        return cell
    }
    
    
}
