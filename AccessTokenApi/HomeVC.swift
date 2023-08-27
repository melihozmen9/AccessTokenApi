//
//  HomeVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit

class HomeVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //self.navigationController?.isNavigationBarHidden = true
    }
    

  

}
