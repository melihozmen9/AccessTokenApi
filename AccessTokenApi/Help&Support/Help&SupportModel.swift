//
//  Help&SupportModel.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 5.09.2023.
//

import Foundation


struct collapsibleCellModel {
    var title:String
    var content:String
    var isExpanded:Bool
    
    init(title: String, content: String, isExpanded: Bool) {
        self.title = title
        self.content = content
        self.isExpanded = isExpanded
    }
}