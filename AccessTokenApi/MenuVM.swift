//
//  MenuVM.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 31.08.2023.
//

import Foundation
import UIKit

class MenuVM {
    
    var labels = ["Security Settings", "App Defaults", "My Added Places", "Helps&Support", "About", "Terms of Use"]
    
    var images = [#imageLiteral(resourceName: "s"), #imageLiteral(resourceName: "Settings1"), #imageLiteral(resourceName: "Settings2"), #imageLiteral(resourceName: "s 1"), #imageLiteral(resourceName: "Settings3"), #imageLiteral(resourceName: "Settings4")]
    
    let images2 = [#imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5"), #imageLiteral(resourceName: "Vector-5")]
    
    func getLabelForRow(indexpath: IndexPath) -> String {
        return labels[indexpath.row]
    }
    
    func getImageForRow(indexpath: IndexPath) -> UIImage {
        return images[indexpath.row]
    }
    
    func getImageForRow2(indexpath: IndexPath) -> UIImage {
        return images2[indexpath.row]
    }

    
}
