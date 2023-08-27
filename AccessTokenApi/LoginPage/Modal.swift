//
//  Modal.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation

struct RegisterResponse: Codable {
    var message: String
    var status: String
}

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken : String
}

struct User: Codable {
     let full_name: String
     let email: String
     let role: String
   
}

struct AddTravelResponse: Codable {
    var message: String
    var status: String
}


