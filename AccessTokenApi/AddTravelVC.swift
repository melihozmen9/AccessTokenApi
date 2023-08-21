//
//  AddTravelVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 19.08.2023.
//

import UIKit
import TinyConstraints

class AddTravelVC: UIViewController {
    
    let viewModal = AddTravelVM()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3
        btn.setTitle(  "Add a new place" , for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubViews(addBtn)
        setupLayout()
    }
    private func setupLayout() {
        addBtn.centerInSuperview()
    }
    
    @objc func addTapped() {
//        var body = Travel(visit_date: "2023-08-10T00:00:00Z", location: "Destination City", information: "Travel details here", image_url: "https://example.com/image.png", latitude: 37.12353, longitude: -122.95421)
        var body = [String:Any]()
        
        body["visit_date"] = "2023-08-10T00:00:00Z"
        body["location"] = "Destination City"
        body["information"] = "Travel details here"
        body["image_url"] = "https://example.com/image.png"
        body["latitude"] = 37.12353
        body["longitude"] = -122.95421
        
        let parameters: [String: Any] = [
            "visit_date": "2023-08-10T00:00:00Z",
            "location": "Istanbul",
            "information": "Explored the Blue Mosque and Hagia Sophia.",
            "image_url": "https://images.pexels.com/photos/6152260/pexels-photo-6152260.jpeg",
            "latitude": 41.0082,
            "longitude": 28.9784
        ]

        viewModal.addTravel(body: parameters)
    }


}
