//
//  Enums.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//
//300 -> regular
//400 -> medium
//500 -> semibold
//600 -> bold
//Regular -> 400
//Medium -> 500
//SemiBold -> 600
//Bold -> 700

import UIKit
enum Font {
    case regular12
    case regular16
    case bold14
    case semibold24
    case semibold16
    case semibold14
    case bold36
    case bold30
    case medium14
    var chooseFont: UIFont {
        switch self {
        case .regular12:
            return UIFont(name: "Poppins-Regular", size: 12)!
        case .regular16:
            return UIFont(name: "Poppins-Regular", size: 16)!
        case .bold14:
            return UIFont(name: "Poppins-Bold", size: 14)!
        case .semibold24:
            return UIFont(name: "Poppins-SemiBold", size: 24)!
        case .semibold16:
            return UIFont(name: "Poppins-SemiBold", size: 16)!
        case .semibold14:
            return UIFont(name: "Poppins-SemiBold", size: 14)!
        case .bold36:
            return UIFont(name: "Poppins-Bold", size: 36)!
        case .bold30:
            return UIFont(name: "Poppins-Bold", size: 30)!
        case .medium14:
            return UIFont(name: "Poppins-Medium", size: 14)!
        }
    }
}

enum Color {
    case systemGreen
    case systemblack
    case systemWhite
    case white
    case systemgray
    case barItemColor
    
    var chooseColor: UIColor {
        switch self {
        case .systemGreen:
            return #colorLiteral(red: 0.2196078431, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        case .systemblack:
            return #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        case .systemWhite:
            return #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .systemgray:
            return #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        case .barItemColor:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        }
    }
}


enum EndPoint {
    static let baseUrl = "https://api.iosclass.live/"
    
    case register
    case login
    case me
    case addTravel
    case listTravel
    var apiUrl: String {
        switch self {
        case .register:
            return EndPoint.baseUrl + "v1/auth/register"
        case .login:
            return EndPoint.baseUrl + "v1/auth/login"
        case .me:
            return EndPoint.baseUrl + "v1/me"
        case .addTravel:
            return EndPoint.baseUrl + "v1/travels"
        case .listTravel:
            return EndPoint.baseUrl + "v1/travels?page=1&limit=10"
        }
    }
}
