//
//  TravelModal.swift
//  AccessTokenApi
//
//  Created by Kullanici on 21.08.2023.
//

import Foundation

struct TravelData: Codable {
    var data: Travel
    var status: String
}
struct Travel: Codable {
    var count: Int
    var travels: [TravelItem]
}

struct TravelItem: Codable {
    let visit_date : String
    let location: String
    let information: String?
    let image_url: String?
    let latitude: Float
    let longitude: Float
}
